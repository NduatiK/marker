defmodule GoldenWeb.UserLive.FormComponent do
  use GoldenWeb, :live_component

  alias Golden.Accounts

  alias ElmView.Input
  require ElmView
  import ElmView

  # ],

  @form el(
          [],
          Input.form(
            %{
              changeset: :changeset,
              on_change: :validate,
              on_submit: :save,
              target: :myself,
              id: "user-form2"
            },
            "#",
            [],
            [
              column([spacing: 4], [
                ElmView.Input.text(
                  [form: :f, id: :name],
                  [],
                  ElmView.Input.label_above([], "Name")
                ),
                ElmView.Input.text(
                  [form: :f, id: :age],
                  [],
                  ElmView.Input.label_above([], "Age")
                ),
                ElmView.Input.text(
                  [form: :f, id: :email],
                  [],
                  ElmView.Input.label_above([], "Email")
                ),
                ElmView.Input.text(
                  [form: :f, id: :image],
                  [],
                  ElmView.Input.label_above([], "Image")
                ),
                ElmView.Input.button(
                  [
                    type: "submit",
                    phx_disable_with: "Saving..."
                  ],
                  on_press: nil,
                  label: ElmView.text("Submit")
                )

                # <div>
                #   <%= submit "Save", phx_disable_with: "Saving..." %>
                # </div>])
              ])
            ]
          )
        )
        |> ElmView.render()
        |> IO.inspect()

  def render(assigns) do
    # ~H"""
    #   <div>
    #   <h2><%= @title %></h2>

    #   <.form
    #     let={f}
    #     for={@changeset}
    #     id="user-form"
    #     phx-target={@myself}
    #     phx-change="validate"
    #     phx-submit="save">

    #     <%= label f, :name %>
    #     <%= text_input f, :name %>
    #     <%= error_tag f, :name %>

    #     <%= label f, :age %>
    #     <%= number_input f, :age %>
    #     <%= error_tag f, :age %>

    #     <div>
    #       <%= submit "Save", phx_disable_with: "Saving..." %>
    #     </div>
    #   </.form>
    # </div>
    # """
    ElmView.compile(@form)
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
  def handle_event("validate", %{"f" => user_params}, socket) do
    changeset =
      socket.assigns.user
      |> Accounts.change_user(user_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"f" => user_params}, socket) do
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
