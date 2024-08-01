# spec/controllers/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  let!(:task1) { Task.create!(name: 'Task One', category: 'work', priority: 'high', status: 'complete') }
  let!(:task2) { Task.create!(name: 'Another Task', category: 'personal', priority: 'low', status: 'incomplete') }
  let!(:task3) { Task.create!(name: 'Yet Another Task', category: 'work', priority: 'high', status: 'complete') }

  # Index method tests
  describe "GET #index" do
    it "assigns all tasks to @tasks" do
      get :index
      expect(assigns(:tasks)).to match_array([task1, task2, task3])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "returns tasks matching the search term" do
      get :index, params: { search: 'Task' }
      expect(assigns(:tasks)).to match_array([task1, task2, task3])

      get :index, params: { search: 'Another' }
      expect(assigns(:tasks)).to match_array([task2, task3])
    end

      it "is case insensitive" do
        #/tasks?search=task.
        get :index, params: { search: 'task' }
        expect(assigns(:tasks)).to match_array([task1, task2, task3])
      end

      it "returns an empty array if no tasks match the search term" do
        get :index, params: { search: 'Nonexistent' }
        expect(assigns(:tasks)).to be_empty
      end
  end

  # Show method tests
  describe "GET #show" do
    it "assigns the requested task to @task" do
      get :show, params: { id: task1.id }
      expect(assigns(:task)).to eq(task1)
    end

    it "renders the show template" do
      get :show, params: { id: task1.id }
      expect(response).to render_template(:show)
    end

    it "returns a successful response" do
      get :show, params: { id: task1.id }
      expect(response).to have_http_status(:success)
    end
  end

  # Test cases new & create method
  describe "GET #new" do
  it "returns a successful response" do
    get :new
    expect(response).to be_successful
  end

  it "renders the new template" do
    get :new
    expect(response).to render_template(:new)
  end

  it "assigns a new Task to @task" do
    get :new
    expect(assigns(:task)).to be_a_new(Task)
  end
end


describe "POST #create" do
context "with valid attributes" do
  let(:valid_attributes) { { name: "Buy groceries", category: "Personal", priority: "High", status: "Pending" } }

  it "creates a new Task" do
    expect {
      post :create, params: { task: valid_attributes }
    }.to change(Task, :count).by(1)
  end

  it "redirects to the show action" do
    post :create, params: { task: valid_attributes }
    expect(response).to redirect_to(task_url(Task.last))
  end

  it "sets a notice flash message" do
    post :create, params: { task: valid_attributes }
    expect(flash[:notice]).to eq("Task was successfully created.")
  end
end
end
context "with invalid attributes" do
  let(:invalid_attributes) { { name: nil, category: nil, priority: nil, status: nil } }

  it "does not create a new Task" do
    expect {
      post :create, params: { task: invalid_attributes }
    }.not_to change(Task, :count)
  end

  it "re-renders the new template" do
    post :create, params: { task: invalid_attributes }
    expect(response).to render_template(:new)
  end

  it "returns an unprocessable entity status" do
    post :create, params: { task: invalid_attributes }
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "assigns the unsaved task as @task" do
    post :create, params: { task: invalid_attributes }
    expect(assigns(:task)).to be_a_new(Task)
  end
end

#update

describe "GET #edit" do
    
    it "returns a successful response" do
      get :edit, params: { id: task1.id }
      expect(response).to be_successful
    end

    it "renders the edit template" do
      get :edit, params: { id: task1.id }
      expect(response).to render_template(:edit)
    end

    it "assigns the requested task to @task" do
      get :edit, params: { id: task1.id }
      expect(assigns(:task)).to eq(task1)
    end
  end


  
  
  describe 'PATCH #update' do
  let!(:task) { Task.create(name: "Initial task", category: "Work", priority: "High", status: "Incomplete") }

    context 'with valid attributes' do
      it 'updates the task and redirects to the task show page (HTML format)' do
        patch :update, params: { id: task.id, task: { name: "updated task" } }
        
        task.reload
        expect(task.name).to eq("Updated task")
        expect(response).to redirect_to(task_url(task))
        expect(flash[:notice]).to eq("Task was successfully updated.")
      end

  
    end

    context 'with invalid attributes' do
      it 'does not update the task and renders the edit template (HTML format)' do
        patch :update, params: { id: task.id, task: { name: "" } }
        
        task.reload
        expect(task.name).to eq("Initial task")  # unchanged
        expect(response).to render_template(:edit)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the task and returns errors (JSON format)' do
        patch :update, params: { id: task.id, task: { name: "" }, format: :json }

        task.reload
        expect(task.name).to eq("Initial task")  # unchanged
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json; charset=utf-8")
        expect(JSON.parse(response.body)).to have_key("name")
      end
    end
  end
   #destory
   describe "DELETE #destroy" do
    context "with HTML format" do
      it "destroys the task" do
        expect {
          delete :destroy, params: { id: task1.id }
        }.to change(Task, :count).by(-1)
      end

      it "redirects to the tasks index with a notice" do
        delete :destroy, params: { id: task1.id }
        expect(response).to redirect_to(tasks_url)
        expect(flash[:notice]).to eq("Task was successfully destroyed.")
      end
    end

    context "with JSON format" do
      it "destroys the task and returns no content" do
        expect {
          delete :destroy, params: { id: task1.id }, format: :json
        }.to change(Task, :count).by(-1)
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
