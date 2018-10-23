module GDrive
    module Mixins
      module Subscribe
        extend ActiveSupport::Concern
        # don't understand how ActiveSupport plays a role in this tbh

        module ClassMethods
          # and don't quite understand this module...think it has something to do with ActiveSupport::Concern tho
          def subscribe_session

            session = GDrive.Authenticate.session

            session.extend(GDrive::AddMethods::Session)

            session.
            session.

            yield session


          end

        end
      end
    end
  end
end
