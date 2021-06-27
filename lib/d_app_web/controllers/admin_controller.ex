defmodule DAppWeb.AdminController do
  import Sage
  use DAppWeb, :controller
  alias DApp.AdminHelper, as: Data

  @doc """
      Program Controller Functions
  """
  def create_program(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_program/2, &abort/4)
    |> run(:create_program, &create_program/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  def update_program(_, params, _) do
    new()
    |> run(:update_program, &update_program/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  def delete_program(_, params, _) do
    new()
    |> run(:delete_program, &delete_program/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  defp authenticate_program(_, %{input: %{name: name}}) do
    case Data.get_program(name) do
      {:error, :program_does_not_exist} -> {:ok, :create_program}
      {:ok, _program} -> {:error, ["program already exist"]}
    end
  end
  defp create_program(%{authenticate: :create_program}, %{input: data}) do
    case Data.create_program(data) do
      {:ok, program} -> {:ok, program}
      _ -> {:error, ["you cannot create program"]}
    end
  end
  defp update_program(_, %{input: data}) do
    case Data.update_program(data) do
      {:ok, program} -> {:ok, program}
      _ -> {:error, ["you cannot update program"]}
    end
  end
  defp delete_program(_, %{input: data}) do
    case Data.delete_program(data) do
      {:ok, program} -> {:ok, program}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
      Semester Controller Functions
  """
  def create_semester(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_semester/2, &abort/4)
    |> run(:create_semester, &create_semester/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  def update_semester(_, params, _) do
    new()
    |> run(:update_semester, &update_semester/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  def delete_semester(_, params, _) do
    new()
    |> run(:delete_semester, &delete_semester/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end


  defp authenticate_semester(_, %{input: %{program_name: name}}) do
    with {:ok, _program} <- Data.get_program(name) do
      {:ok, :can_create_semester}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
    end
  end
  defp create_semester(%{authenticate: :can_create_semester}, %{input: %{semester: semester, program_name: program_id}}) do
    case Data.create_semester(%{semester: semester, program_id: program_id}) do
      {:ok, semester} -> {:ok, semester}
      _ -> {:error, ["You Cannot Create Semester"]}
    end
  end
  defp update_semester(_, %{input: data}) do
    case Data.update_semester(data) do
      {:ok, semester} -> {:ok, semester}
      _ -> {:error, ["You Cannot Update Semester"]}
    end
  end
  defp delete_semester(_, %{input: data}) do
    case Data.delete_semester(data) do
      {:ok, semester} -> {:ok, semester}
      {:error, error} -> {:error, error}
    end
  end

  @doc """
      Courses Controller Functions
  """
  def create_course(_, params, _) do
    new()
    |> run(:authenticate, &authenticate_course/2, &abort/4)
    |> run(:create_course, &create_course/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  def update_course(_, params, _) do
    new()
    |> run(:update_course, &update_course/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end

  def delete_course(_, params, _) do
    new()
    |> run(:delete_course, &delete_course/2, &abort/4)
    |> transaction(DApp.Repo, params)
  end


  defp authenticate_course(_, %{input: %{id: id}}) do
    with {:ok, _program} <- Data.get_course(id) do
      {:ok, :can_create_course}
    else
      {:error, :program_does_not_exist} -> {:error, ["This Program Doesn't Exist"]}
    end
  end
  defp create_course(%{authenticate: :can_create_course}, %{input: data}) do
    case Data.create_course(data) do
      {:ok, course} -> {:ok, course}
      _ -> {:error, ["You Cannot Create course"]}
    end
  end
  defp update_course(_, %{input: data}) do
    case Data.update_course(data) do
      {:ok, course} -> {:ok, course}
      _ -> {:error, ["You Cannot Update course"]}
    end
  end
  defp delete_course(_, %{input: data}) do
    case Data.delete_course(data) do
      {:ok, course} -> {:ok, course}
      {:error, error} -> {:error, error}
    end
  end

  defp abort(_, _, _, _) do
    :abort
  end
end