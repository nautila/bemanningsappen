CREATE MIGRATION m1rvt5ow62d3hyiq2jhwag3uje22aqvafh3orjozxtajwjxme24xya
    ONTO m1oy2b63fvykmrjkmier2556pb7fztzg4fwamwuaxcjeq2e66jtnja
{
  CREATE MODULE image IF NOT EXISTS;
  CREATE MODULE time IF NOT EXISTS;
  ALTER TYPE employer::Profile {
      CREATE REQUIRED LINK employer: default::Employer {
          SET REQUIRED USING (<default::Employer>{});
          CREATE CONSTRAINT std::exclusive;
      };
  };
  ALTER TYPE default::Employer {
      CREATE LINK profile := (.<employer[IS employer::Profile]);
  };
  ALTER TYPE default::Employer {
      DROP PROPERTY name;
  };
  CREATE TYPE image::Image {
      CREATE REQUIRED PROPERTY data: std::bytes;
      CREATE REQUIRED PROPERTY name: std::str;
  };
  ALTER TYPE employer::Profile {
      CREATE LINK logo: image::Image;
  };
  ALTER TYPE employer::Profile {
      CREATE PROPERTY description: std::str;
  };
  ALTER TYPE employer::Profile {
      ALTER PROPERTY idNumber {
          RENAME TO address;
      };
  };
  ALTER TYPE employer::Profile {
      ALTER PROPERTY address {
          RESET OPTIONALITY;
      };
      ALTER PROPERTY name {
          RESET OPTIONALITY;
      };
  };
  CREATE ABSTRACT TYPE time::CreatedAt {
      CREATE REQUIRED PROPERTY createdAt: std::datetime {
          SET default := (std::datetime_current());
          SET readonly := true;
      };
      CREATE REQUIRED PROPERTY sinceCreated := ((std::datetime_of_statement() - .createdAt));
      CREATE INDEX ON (.createdAt);
  };
  CREATE ABSTRACT TYPE time::UpdatedAt {
      CREATE REQUIRED PROPERTY updatedAt: std::datetime {
          SET default := (std::datetime_current());
          CREATE REWRITE
              UPDATE 
              USING (std::datetime_current());
      };
      CREATE INDEX ON (.updatedAt);
      CREATE REQUIRED PROPERTY sinceUpdated := ((std::datetime_of_statement() - .updatedAt));
  };
  CREATE ABSTRACT TYPE time::Timestamped EXTENDING time::CreatedAt, time::UpdatedAt;
  CREATE TYPE matcher::EmployerWorkerAvailabilityRequest EXTENDING time::Timestamped {
      CREATE REQUIRED LINK employer: default::Employer;
      CREATE REQUIRED LINK worker: default::Worker;
  };
};
