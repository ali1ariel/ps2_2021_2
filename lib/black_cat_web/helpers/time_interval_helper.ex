defmodule BlackCat.Helpers.TimeIntervalHelper do
  alias BlackCat.Helpers.Month


  def interval(time_now, intervals) do
    case IO.inspect Enum.find(intervals,
    fn interval ->
        (Date.day_of_week(time_now) |> Month.day_of_week_atom()  == interval.init_day) and

        (Time.compare("#{interval.init_time}" |> Time.from_iso8601!() |> IO.inspect, time_now |> DateTime.to_time()) == :lt) and
        (Time.compare("#{interval.end_time}" |> Time.from_iso8601!(), time_now |> DateTime.to_time()) == :gt)
      end) do
        nil -> "<div class=\"font-bold text-red-800\">🟥 false</div>"
        _ -> "<div class=\"font-bold text-green-800\">🟢 true</div>"
    end
  end

  def handle_interval(%{init_time: init_time, end_time: end_time, init_day: init_day}) do

  end

end
