defmodule GoldenWeb.UserLive.FormComponent2 do
  use GoldenWeb, :live_component

  use Marker
  require Marker.HTML
  import Element
  alias Element.Input, as: Input
  alias Golden.Accounts

  def render(assigns) do
    ~H"""
    """

    column spacing: 4, id: "av", class: "mango" do
      Input.text(
        id: "above",
        attrs: [id: "aj"],
        label: Input.label_above("Above")
      )

      # input(
      #   class:
      #     "w-full px-3 py-2 text-sm leading-tight text-gray-700 border rounded shadow appearance-none focus:outline-none focus:shadow-outline",
      #   id: "firstName",
      #   type: "text",
      #   placeholder: "First Name"
      # )

      Input.text(
        id: "below",
        attrs: [],
        label: Input.label_below("Below")
      )

      Input.text(
        id: "left",
        attrs: [],
        label: Input.label_left("Left")
      )

      Input.text(
        id: "right",
        attrs: [],
        label: Input.label_right("Right")
      )
    end
  end

  @impl true
  def update(%{user: user} = assigns, socket) do
    changeset = Accounts.change_user(user)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Accounts.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.action, user_params)
  end

  defp save_user(socket, :edit, user_params) do
    case Accounts.update_user(socket.assigns.user, user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_user(socket, :new, user_params) do
    case Accounts.create_user(user_params) do
      {:ok, _user} ->
        {:noreply,
         socket
         |> put_flash(:info, "User created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
