require "spec_helper"

describe Crashdesk::Services::AddCollaboratorToApp do
  let(:laco) { FactoryGirl.create(:user, email: 'laco@laco.com') }
  let(:zdenal) { FactoryGirl.create(:user, email: 'zdenal@zdenal.com') }
  let(:crashdesk) { @crashdesk = FactoryGirl.create(:app, users: [zdenal]) }
  subject { crashdesk }

  its(:users) { should include(zdenal) }
  its(:users) { should have(1).items }
  its(:tmp_users) { should be_blank }


  describe 'add existing user to app' do
    before(:all) do
      # call laco -> is 'let' so make sure that he is created
      laco
      Crashdesk::Services::AddCollaboratorToApp.new(
        app: crashdesk,
        params: {email: 'laco@laco.com'},
        inviter: zdenal
      ).run
    end
    it "app should include laco as collaborator" do
      crashdesk.users.should include(laco)
      crashdesk.users.should have(2).items
      crashdesk.tmp_users.should be_blank
    end
  end

  describe 'add non existing user to app' do
    before(:all) do
      @new_user = Crashdesk::Services::AddCollaboratorToApp.new(
        app: crashdesk,
        params: {email: 'laco@laco.com'},
        inviter: zdenal
      ).run
    end
    it "app should include laco as collaborator" do
      crashdesk.tmp_users.should include(@new_user)
      crashdesk.tmp_users.should have(1).items
      crashdesk.users.should have(1).items
    end
  end

  describe 'add already added user to app' do
    let(:crashdesk) { @crashdesk = FactoryGirl.create(:app, users: [zdenal, laco]) }
    before(:all) do
      @new_user = Crashdesk::Services::AddCollaboratorToApp.new(
        app: crashdesk,
        params: {email: 'laco@laco.com'},
        inviter: zdenal
      ).run
    end
    it "user should have error on email" do
      @new_user.errors.messages.should have(1).error_on(:email)
      crashdesk.tmp_users.should be_blank
      crashdesk.users.should have(2).items
    end
    it "user should have User class" do
      @new_user.should be_an_instance_of User
    end
  end

  describe 'add already added tmp_user to app' do
    before(:all) do
      crashdesk.tmp_users << FactoryGirl.create(:tmp_user, email: 'tmp@user.com')
      @new_user = Crashdesk::Services::AddCollaboratorToApp.new(
        app: crashdesk,
        params: {email: 'tmp@user.com'},
        inviter: zdenal
      ).run
    end
    it "user should have error on email" do
      @new_user.errors.messages.should have(1).error_on(:email)
      crashdesk.tmp_users.should have(1).items
      crashdesk.users.should have(1).items
    end
    it "user should have TmpUser class" do
      @new_user.should be_an_instance_of TmpUser
    end
  end
end

