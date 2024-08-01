require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:task) { Task.new(name: 'Sample Task',category: 'personal', priority: 'High', status: 'incomplete') }
  describe 'validations' do 

    it 'is valid with valid all attributes' do
      task = Task.new(name: 'Test Task', category: 'Work', priority: 1, status: 'Incomplete')
      expect(task).to be_valid
    end

    it 'is not valid without name' do
      task = Task.new(name: nil)
      expect(task).not_to be_valid
    end

    it 'is not valid without category' do
      task = Task.new(category: nil)
      expect(task).not_to be_valid
    end
    
    it 'is not valid without priority' do
      task = Task.new(priority: nil)
      expect(task).not_to be_valid
    end

    it 'is not valid without status' do
      task = Task.new(status: nil)
      expect(task).not_to be_valid
    end

  end

  it 'capitalizes the first letter of the name before saving' do
    task = Task.new(name: 'test task', category: 'Work', priority: 1, status: 'Incomplete')
    task.save
    expect(task.name).to eq('Test task')
  end

  it 'does not alter an already capitalized name' do
    task = Task.new(name: 'Test task', category: 'Work', priority: 1, status: 'Incomplete')
    task.save
    expect(task.name).to eq('Test task')
  end
  
end
