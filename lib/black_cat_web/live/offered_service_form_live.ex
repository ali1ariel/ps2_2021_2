defmodule BlackCatWeb.OfferedServiceFormLive do
  use BlackCatWeb, :live_view

  def render(assigns) do
    ~L"""
      <div> Hello </div>
    """
  end

  def mount(_params, _, socket), do: {:ok, socket}
end
