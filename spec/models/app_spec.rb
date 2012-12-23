require 'spec_helper'

describe App do

  let(:app) { FactoryGirl.create(:app) }
  let(:zdenal) { FactoryGirl.create(:user, email: 'zdenal@zdenal.com') }
  let(:laco) { FactoryGirl.create(:user, email: 'laco@laco.com') }
  let(:tmp_user) { FactoryGirl.create(:tmp_user) }

  describe 'collaborators' do
    before do
      app.add_collaborator(zdenal)
    end

    it "zdenal is in users" do
      app.users.should include(zdenal)
      app.users.should have(1).items
    end

    context 'when we are adding existing user to app' do

      it "should add Laco to collaborators" do
        lambda {
          app.add_collaborator(laco)
        }.should change(app.users, :count).by(1)
      end

      it "should not add already added user" do
        lambda {
          app.add_collaborator(zdenal)
        }.should_not change(app.users, :count)
        # zdenal.should have(1).error_on(:email) doesn't work properly
        zdenal.errors[:email].should_not be_blank
      end

    end

    context 'when we are adding new user to app' do

      it "should add new user to tmp_users collaborators" do
        lambda {
          app.add_collaborator(tmp_user)
        }.should change(app.tmp_users, :count).by(1)
      end

      it "should not add already added tmp_user" do
        app.add_collaborator(tmp_user)
        lambda {
          app.add_collaborator(tmp_user)
        }.should_not change(app.tmp_users, :count)
        # tmp_user.should have(1).error_on(:email) doesn't work properly
        tmp_user.errors[:email].should_not be_blank
      end

    end

    context 'when we add new app to tmp_user' do
      let(:app2) { FactoryGirl.create(:app) }
      before do
        app.add_collaborator(tmp_user)
        app2.add_collaborator(tmp_user)
      end

      it "tmp_user should has app & app2 in apps" do
        tmp_user.apps.should include(app)
        tmp_user.apps.should include(app2)
      end
    end

    context 'when we remove collaborator from app' do
      before(:all) do
        app.add_collaborator(laco)
      end
      it "should remove Laco from app" do
        app.remove_collaborator(laco)
        app.users.should_not include(laco)
        assert(app.persisted?)
      end
      it "should remove app with last collaborator" do
        app.remove_collaborator(zdenal)
        app.users.should be_blank
        assert(app.deleted?)
      end
    end

  end

end
