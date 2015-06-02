There is an inconsistency between transaction rollbacks when an active record model has no has many relationships and when it has one. 


In the former case, if a record is created and then rolled back the instance will have an id set. 
In the latter case, if a record is created and then rolled back the instance will NOT have an id set. It will be nil.

This repo's first two commits demonstrate the issue. To reproduce, checkout the first commit (53cc48f) and then in the console do the following:

```
bob = nil
ActiveRecord::Base.transaction { bob = Bob.create; p bob.id; raise}
bob
```

You will see something like (note the non-nil id):

```
#<Bob id: 1, created_at: "2015-06-02 20:11:59", updated_at: "2015-06-02 20:11:59">
```

Checkout the second commit (dbdb961) which adds `has_many :joes` to `Bob`. In a fresh console repeat the steps above. You will see:

```
#<Bob id: nil, created_at: "2015-06-02 20:15:59", updated_at: "2015-06-02 20:15:59">
```

We have tested under the following conditions:

- Ruby 2.1.2
- Rails 4.2.0 and 4.2.1
- Postgres and Sqlite3

We discovered the issue while upgrading from 3.2 to 4.2.0. Rails 3.2 does not have the same inconsistency. 
