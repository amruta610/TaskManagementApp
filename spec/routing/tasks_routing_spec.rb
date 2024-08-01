# spec/routing/tasks_routing_spec.rb
require 'rails_helper'

RSpec.describe 'Tasks routing', type: :routing do
  it 'routes GET /tasks to the tasks#index action' do
    expect(get: '/tasks').to route_to('tasks#index')
  end

  it 'routes GET /tasks/new to the tasks#new action' do
    expect(get: '/tasks/new').to route_to('tasks#new')
  end

  it 'routes POST /tasks to the tasks#create action' do
    expect(post: '/tasks').to route_to('tasks#create')
  end

  it 'routes GET /tasks/:id to the tasks#show action' do
    expect(get: '/tasks/1').to route_to('tasks#show', id: '1')
  end

  it 'routes GET /tasks/:id/edit to the tasks#edit action' do
    expect(get: '/tasks/1/edit').to route_to('tasks#edit', id: '1')
  end

  it 'routes PATCH /tasks/:id to the tasks#update action' do
    expect(patch: '/tasks/1').to route_to('tasks#update', id: '1')
  end

  it 'routes PUT /tasks/:id to the tasks#update action' do
    expect(put: '/tasks/1').to route_to('tasks#update', id: '1')
  end

  it 'routes DELETE /tasks/:id to the tasks#destroy action' do
    expect(delete: '/tasks/1').to route_to('tasks#destroy', id: '1')
  end

  it 'routes GET / to the home#index action as the root route' do
    expect(get: '/').to route_to('home#index')
  end
end