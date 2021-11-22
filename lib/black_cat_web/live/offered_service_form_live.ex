defmodule BlackCatWeb.OfferedServiceFormLive do
  use BlackCatWeb, :live_view
  alias BlackCat.OfferedServices
  alias BlackCatWeb.Live.TimeIntervalComponent

  def render(assigns) do
    ~L"""
      <%= f = form_for OfferedServices.OfferedService.changeset(%OfferedServices.OfferedService{}, %{}), "", [] %>

        <%= inputs_for f, :time_interval, fn time_interval -> %>
          <%= select time_interval, :init_day, Ecto.Enum.mappings(OfferedServices.TimeInterval, :init_day)  %>
          <%= time_input time_interval, :init_time, precision: :minute %>
          <%= time_input time_interval, :end_time, precision: :minute %>

          <div class="py-6 px-4 md:p-8 shadow-lg border border-gray-200 mb-4">
            <div class="flex justify-between">
              <p class="subtitle text-base md:text-lg">Author <%= time_interval.index + 1 %></p>
              <button type="button" class="btn-floating bg-color-orange-dark tooltip" style="float:right"
                phx-value-remove="<%= time_interval.params[:temp_id] || time_interval.params["temp_id"] || time_interval.source.changes[:temp_id] || time_interval.data.id %>"
                phx-click="remove-time_interval">
                X
                <span class="tooltip-text -mt-6 font-normal">Remove Author</span></button>
              </button>
            </div>
            <%= hidden_input time_interval, :temp_id, value: time_interval.params[:temp_id] || time_interval.params["temp_id"] || time_interval.source.changes[:temp_id] || time_interval.data.id %>
          </div>
        <% end %>


        <button type="button" phx-click="add-time_interval"
          class="btn bg-color-orange-dark hover:bg-color-orange-light w-full my-2 md:w-48">
          Add Author <i class="fas fa-plus-circle fa-md pl-3"></i>
        </button>


        <%= live_component @socket, TimeIntervalComponent %>
      </form>
    """
  end

  def mount(_params, _, socket), do: {:ok, socket}

  def mount(
        _params,
        %{
          "action" => action,
          "method" => method,
          "csrf_token" => csrf_token,
          "changeset" => changeset,
          "submission" => submission,
          "current_user_id" => current_user_id
        },
        socket
      ) do
    data = Repo.preload(changeset.data, [:time_intervals])

    assigns = [
      csrf_token: csrf_token,
      method: method,
      conn: socket,
      # id_time_intervals: time_intervals_id,
      # showing_time_interval: "",
      display_fields: false,
      # time_interval_name: "",
      # time_interval_email: "",
      # time_interval_document: "",
      file: "",
      action: action,
      changeset:
        if(changeset != nil, do: changeset, else: Submissions.change_submission(%Submission{})),
      # changeset_time_interval: CGApi.change_time_interval_not_subscribed(%time_intervalNotSubscribed{}),
      submission_type_id: Integer.to_string(submission.submission_type.id),
      submission_type_max_time_intervals: submission.submission_type.max_time_intervals,
      id: "form_submission",
      time_intervals: data.time_intervals,
      removed_ids: []
    ]

    {:ok, assign(socket, assigns)}
  end

  def mount(
        _params,
        %{
          "action" => action,
          "method" => method,
          "csrf_token" => csrf_token,
          "changeset" => changeset,
          "submission_type" => submission_type,
          "current_user_id" => current_user_id
        },
        socket
      ) do
    data = Repo.preload(changeset.data, [:time_intervals])

    assigns = [
      csrf_token: csrf_token,
      method: method,
      conn: socket,
      # id_time_intervals: time_intervals_id,
      # showing_time_interval: "",
      display_fields: false,
      # time_interval_name: "",
      # time_interval_email: "",
      # time_interval_document: "",
      file: "",
      action: action,
      changeset:
        if(changeset != nil,
          do: changeset,
          else:
            Submissions.change_submission(
              %Submission{}
              |> Repo.preload([:time_intervals])
            )
        ),
      # changeset_time_interval: CGApi.change_time_interval_not_subscribed(%time_intervalNotSubscribed{}),
      submission_type_id: Integer.to_string(submission_type.id),
      submission_type_max_time_intervals: submission_type.max_time_intervals,
      id: "form_submission",
      time_intervals: data.time_intervals,
      removed_ids: []
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", %{"submission" => submission_params}, socket) do
    submission_params =
      submission_params
      |> Map.update("time_intervals", nil, fn time_intervals ->
        Enum.map(time_intervals, fn {_, time_intervals} ->
          Accounts.change_time_interval_not_subscribed(time_intervals)
        end)
      end)

    assigns = [
      # id_time_intervals: socket.assigns.id_time_intervals,
      changeset:
        %Submission{}
        |> Submission.changeset(submission_params)
        |> Map.put(:action, :insert)
    ]

    {:noreply, assign(socket, assigns)}
  end

  def handle_event("remove-time_interval", %{"remove" => remove_id}, socket) do
    removed_ids = [remove_id | socket.assigns.removed_ids]

    time_intervals =
      if socket.assigns.action == "/submissions",
        do: socket.assigns.changeset.changes[:time_intervals],
        else:
          socket.assigns[:time_intervals] ||
            socket.assigns.changeset.data.time_intervals

    time_intervals =
      time_intervals
      |> Enum.reject(fn
        %Ecto.Changeset{} = coautor ->
          (coautor.data.temp_id || coautor.changes[:temp_id] || Integer.to_string(coautor.data.id)) ==
            remove_id

        %SomaliLiveProject.CGApi.time_intervalNotSubscribed{} = coautor ->
          coautor.temp_id || Integer.to_string(coautor.id) == remove_id

        coautor ->
          coautor.temp_id == remove_id
      end)

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:time_intervals, time_intervals)

    {:noreply,
     assign(socket,
       changeset: changeset,
       time_intervals: time_intervals,
       removed_ids: removed_ids
     )}
  end

  def handle_event("add-time_interval", _, socket) do
    changes = socket.assigns.changeset.changes

    data = socket.assigns.changeset.data |> Repo.preload([:time_intervals])

    time_intervals =
      Map.get(
        changes,
        :time_intervals,
        Map.get(data, :time_intervals, [])
      )
      |> Enum.map(fn
        %time_intervalNotSubscribed{} = time_interval -> time_interval
        %Ecto.Changeset{} = time_interval -> time_interval
      end)

    removed_time_intervals =
      Enum.filter(time_intervals, fn time_interval ->
        time_interval not in socket.assigns.time_intervals ||
          time_interval not in Enum.map(
            socket.assigns.time_intervals,
            &Map.get(&1, :changes, &1)
          )
      end)

    time_intervals =
      if removed_time_intervals == Enum.map(time_intervals, & &1) do
        if String.starts_with?(socket.assigns.action, "/submissions/") do
          Enum.filter(time_intervals, fn time_interval ->
            (time_interval.changes[:temp_id] != nil and
               time_interval.changes[:temp_id] not in socket.assigns.removed_ids) ||
              (time_interval.data.id != nil and
                 Integer.to_string(time_interval.data.id) not in socket.assigns.removed_ids)
          end)
        else
          time_intervals
        end
      else
        Enum.filter(time_intervals, fn time_interval -> time_interval not in removed_time_intervals end)
      end

    time_intervals =
      time_intervals ++
        [%{fullname: "", email: "", temp_id: get_temp_id()}]

    changeset =
      socket.assigns.changeset.data
      |> Submission.changeset(Map.put(changes, :time_intervals, time_intervals))
      |> Map.put(:action, "insert")

    {:noreply, assign(socket, changeset: changeset, time_intervals: time_intervals)}
  end

  def handle_event("submit", _, socket), do: {:noreply, socket}

  defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)
end
