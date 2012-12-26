require "spec_helper"

describe Crashdesk::Services::SignIn do
  let(:email) {'zdenal@zdenal.com'}
  let(:auth) {
    OmniAuth::AuthHash.new(provider: 'Github', uid: 'fds2334fd',
      info: {name: 'Zdenal', email: email}
    )
  }
  let(:zdenal) {
    FactoryGirl.create(:user, email: email,
      provider: auth.provider,
      uid: auth.uid
    )
  }
  let(:crashdesk) {FactoryGirl.create(:app)}
  let(:tmp_zdenal) {
    FactoryGirl.create(:tmp_user, email: email,
      apps: [crashdesk])
  }
  let(:sign_in_service) { Crashdesk::Services::SignIn.new(auth) }

  context 'when user already exists' do
    it "should not create new user" do
      zdenal
      Crashdesk::Services::ImportAppsFromTmpUser.any_instance.expects(:run).never
      lambda {
        sign_in_service.run!
      }.should_not change(User, :count)
    end
  end

  context 'when user is new without assigned apps' do
    it "should create new user" do
      Crashdesk::Services::ImportAppsFromTmpUser.any_instance.expects(:run).never
      lambda {
        sign_in_service.run!
      }.should change(User, :count).by(1)
    end
    it "should have blank apps" do
      sign_in_service.run!
      sign_in_service.user.apps.should be_blank
    end
  end

  context 'when user is new with assigned apps' do
    before do
      tmp_zdenal
      Crashdesk::Services::ImportAppsFromTmpUser.any_instance.expects(:run).times(1)
    end
    it "should create new user" do
      lambda {
        sign_in_service.run!
      }.should change(User, :count).by(1)
    end
    it "should import apps" do
      sign_in_service.run!
      sign_in_service.user.apps.should include(crashdesk)
      sign_in_service.user.apps.should have(1).items
    end
  end

end
