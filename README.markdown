has_overrides
=============

This ActiveRecord plugin allows you to define methods that override attribute
getters and setters using a very natural, object-oriented syntax where super
works just like you'd expect it to, instead of using the awkward read_attribute
and write_attribute methods.

This plugin is actually quite simple, weighing in at less than 60 lines of code,
and relying on the power of ruby's singleton class to make object orientation work.


Example
=======

To use, simply define your attributes in a sub-module named "Overrides" and declare
that the class has_overrides.

    class Post < ActiveRecord::Base

      has_overrides
  
      module Overrides
        def title=(t)
          super(t.titleize)
        end
      end
    end

Once you've done that things just work:

    $ ./script/console 
    Loading development environment (Rails 2.3.2)
    >> post = Post.new(:title => "a simple title")
    => #<Post id: nil, title: "A Simple Title", body: nil, created_at: nil, updated_at: nil>
    >> another_post = Post.create(:title => "this is created just now")
    => #<Post id: 3, title: "This Is Created Just Now", body: nil, created_at: "2009-07-03 04:41:50", updated_at: "2009-07-03 04:41:50">
    >> post.title = "another simple title"
    => "another simple title"
    >> post.title
    => "Another Simple Title"
    >> post.update_attributes(:title => "updated title")
    => true
    >> post.title
    => "Updated Title"
    >> post.update_attribute(:title, "singly updated title")
    => true
    >> post.title
    => "Singly Updated Title"


  

Copyright (c) 2009 Christopher M. Eppstein, released under the MIT license
