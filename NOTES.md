Question for Mike:
  - Logging?
  - Puma? Nginx?
  - Tools for checking Memory
  - How do you deal with instances created in another module but that you want to extend with methods from a class that inherits that other module? (See gdrive session or client methods)


Save Mem Ideas:
  use ||= for session in commands?
  use symbols for variables in commands?
  https://www.sitepoint.com/ruby-uses-memory/
  https://matt.aimonetti.net/posts/2010/07/29/object-allocation-why-you-should-care/

why are we doing _match as one of the command arguments?

Do we need check attendance and attendance commands?

need to implement error handling module

What is build


client.store
  => #<Slack::RealTime::Store:0x007ff0bf1195d8
        @users=
          {"B02N4T4NP"=>
            {"id"=>"U1542GR7E",
            "team_id"=>"T02MD9XTF",
            "name"=>"cenkerdemir",
            "deleted"=>false,
            "color"=>"965d1b",
            "real_name"=>"Cenker Demir",
            "tz"=>"Europe/Athens",
            "tz_label"=>"Eastern European Summer Time",
            "tz_offset"=>10800,
            "profile"=>
              {"title"=>"",
              "phone"=>"",
              "skype"=>"",
              "real_name"=>"Cenker Demir",
              "real_name_normalized"=>"Cenker Demir",
              "display_name"=>"cenkerdemir",
              "display_name_normalized"=>"cenkerdemir",
              "fields"=>[],
              "status_text"=>"",
              "status_emoji"=>"",
              "status_expiration"=>0,
              "avatar_hash"=>"g9c59056ed17",
              "email"=>"cenker.demir@flatironschool.com",
              "first_name"=>"Cenker",
              "last_name"=>"Demir",
              "status_text_canonical"=>"",
              "team"=>"T02MD9XTF"}
            }
