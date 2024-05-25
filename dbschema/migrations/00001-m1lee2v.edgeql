CREATE MIGRATION m1lee2vi5wzsdadldtfwsgsyln7dekwd3awgp5opnbhjblzfp3srya
    ONTO initial
{
  CREATE EXTENSION pgcrypto VERSION '1.3';
  CREATE EXTENSION auth VERSION '1.0';
  CREATE MODULE chat IF NOT EXISTS;
  CREATE MODULE employer IF NOT EXISTS;
  CREATE MODULE matcher IF NOT EXISTS;
  CREATE MODULE worker IF NOT EXISTS;
  CREATE MODULE worker::experience IF NOT EXISTS;
  CREATE MODULE worker::qualification IF NOT EXISTS;
  CREATE MODULE worker::qualification::license IF NOT EXISTS;
  CREATE TYPE default::User {
      CREATE MULTI LINK identities: ext::auth::Identity;
      CREATE PROPERTY dateOfBirth: std::datetime;
      CREATE PROPERTY firstName: std::str;
      CREATE PROPERTY lastName: std::str;
  };
  CREATE GLOBAL default::ClientUser := (std::assert_single((SELECT
      default::User
  FILTER
      (GLOBAL ext::auth::ClientTokenIdentity IN .identities)
  )));
  CREATE ABSTRACT TYPE default::Account;
  CREATE TYPE default::Worker EXTENDING default::Account {
      CREATE REQUIRED LINK user: default::User {
          CREATE CONSTRAINT std::exclusive;
      };
  };
  CREATE ABSTRACT TYPE worker::Experience {
      CREATE REQUIRED LINK worker: default::Worker;
      CREATE PROPERTY description: std::str;
      CREATE PROPERTY endDate: std::datetime;
      CREATE REQUIRED PROPERTY startDate: std::datetime;
  };
  CREATE ABSTRACT TYPE worker::Qualification {
      CREATE REQUIRED LINK worker: default::Worker;
      CREATE PROPERTY expiresAt: std::datetime;
      CREATE REQUIRED PROPERTY issuedAt: std::datetime;
      CREATE PROPERTY issuedBy: std::str;
  };
  CREATE ABSTRACT TYPE worker::Skill {
      CREATE REQUIRED LINK worker: default::Worker;
  };
  CREATE TYPE worker::CV {
      CREATE REQUIRED LINK worker: default::Worker {
          CREATE CONSTRAINT std::exclusive;
      };
      CREATE ACCESS POLICY worker_has_full_access
          ALLOW ALL USING ((.worker ?= GLOBAL default::ClientUser));
      CREATE ACCESS POLICY others_read_only
          ALLOW SELECT ;
      CREATE MULTI LINK experiences: worker::Experience {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE MULTI LINK qualifications: worker::Qualification {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE MULTI LINK skills: worker::Skill {
          ON SOURCE DELETE DELETE TARGET IF ORPHAN;
      };
      CREATE PROPERTY introduction: std::str;
      CREATE PROPERTY tagline: std::str;
      CREATE REQUIRED PROPERTY title: std::str;
  };
  CREATE TYPE chat::Conversation {
      CREATE MULTI LINK participants: default::User;
  };
  CREATE TYPE chat::Message {
      CREATE REQUIRED LINK conversation: chat::Conversation {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE REQUIRED PROPERTY index: std::int64;
      CREATE CONSTRAINT std::exclusive ON ((.conversation, .index));
      CREATE INDEX ON (.index);
      CREATE REQUIRED LINK author: default::User {
          ON TARGET DELETE DELETE SOURCE;
      };
      CREATE REQUIRED PROPERTY body: std::str;
  };
  ALTER TYPE chat::Conversation {
      CREATE MULTI LINK messages := (.<conversation[IS chat::Message]);
      CREATE SINGLE LINK lastMessage := (SELECT
          .messages ORDER BY
              .index DESC
      LIMIT
          1
      );
  };
  CREATE TYPE default::Employer EXTENDING default::Account {
      CREATE MULTI LINK users: default::User;
      CREATE PROPERTY name: std::str;
  };
  CREATE TYPE matcher::Matching {
      CREATE MULTI LINK conversation: chat::Conversation;
      CREATE REQUIRED LINK employer: default::Employer;
      CREATE REQUIRED LINK worker: default::Worker;
      CREATE REQUIRED PROPERTY matchMade: std::bool {
          SET default := false;
      };
  };
  CREATE TYPE worker::WorkingHours {
      CREATE REQUIRED PROPERTY endTime: cal::local_time;
      CREATE REQUIRED PROPERTY startTime: cal::local_time;
  };
  CREATE SCALAR TYPE worker::JobType EXTENDING enum<Driving, Cooking, Cleaning, Moving>;
  CREATE ABSTRACT TYPE worker::Desires {
      CREATE REQUIRED LINK worker: default::Worker;
      CREATE MULTI LINK preferredWorkingHours: worker::WorkingHours;
      CREATE REQUIRED PROPERTY desiredJobType: worker::JobType;
  };
  CREATE TYPE worker::experience::Project EXTENDING worker::Experience {
      CREATE PROPERTY project: std::str;
      CREATE PROPERTY role: std::str;
  };
  CREATE TYPE worker::experience::Course EXTENDING worker::Experience {
      CREATE PROPERTY course: std::str;
      CREATE PROPERTY provider: std::str;
  };
  CREATE TYPE worker::experience::Education EXTENDING worker::Experience {
      CREATE PROPERTY degree: std::str;
      CREATE PROPERTY school: std::str;
  };
  CREATE TYPE worker::experience::Work EXTENDING worker::Experience {
      CREATE PROPERTY company: std::str;
      CREATE PROPERTY position: std::str;
  };
  CREATE TYPE worker::qualification::Degree EXTENDING worker::Qualification;
  CREATE TYPE worker::qualification::Certification EXTENDING worker::Qualification;
  CREATE TYPE worker::qualification::License EXTENDING worker::Qualification;
  CREATE TYPE worker::qualification::license::DriversLicense EXTENDING worker::qualification::License {
      CREATE MULTI PROPERTY classes: std::str;
      CREATE PROPERTY region: std::str;
  };
  CREATE TYPE employer::Profile {
      CREATE REQUIRED PROPERTY idNumber: std::str;
      CREATE REQUIRED PROPERTY name: std::str;
  };
};
