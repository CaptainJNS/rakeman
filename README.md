# Rakeman

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rakeman'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rakeman

Then run:

    $ rails g rakeman:install
    $ rails rakeman:install:migrations
    $ rails db:migrate

Make sure your policy is allowing to access Rakeman controllers

## Usage
At first time you load `/rakeman` page Rakeman will fetch all your project rake tasks and save them as `Rakeman::RakeTask` model.

Rakeman provides several actions:

Create an instance of `Rakeman::Manager` and call on it:
 - `#tasks` to fetch all tasks in your project. The output data will be array of hashes:
   ```ruby
   [
    {
      name: 'task1',
      description: 'Task 1 Description'
    },
    {
      name: 'task2',
      description: 'Task 2 Description'
    }
   ]
 - `#persist_tasks(tasks_list: nil, destroy_old_tasks: true)` to save tasks to DB. By default it destroys ALL previous tasks in DB and creates new instead from all your project tasks. `tasks_list` must be an array of hashes such as above.
 - `#update_tasks_list` to update DB with new tasks and destroy old ones that you don't have in project anymore.
 - `#mark_as_done(task)` to mark your task as done
 - `#mark_as_undone(task)` to mark your task as undone
 - `#execute(task)` to execute your task. It also marks your task as done<br>
 <span style="color:red">Only rake tasks without params can be executed. Feature that allows to run tasks with params will be released in next version. Sorry =(</span>

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CaptainJNS/rakeman. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/CaptainJNS/rakeman/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Rakeman project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/CaptainJNS/rakeman/blob/master/CODE_OF_CONDUCT.md).
