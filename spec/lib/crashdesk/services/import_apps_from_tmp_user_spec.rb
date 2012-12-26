require "spec_helper"

describe Crashdesk::Services::ImportAppsFromTmpUser do
  before do
    @crashdesk = FactoryGirl.create(:app)
    @harvester = FactoryGirl.create(:app)
    @zdenal = FactoryGirl.create(:user, email: 'zdenal@zdenal.com')
    @tmp_zdenal = FactoryGirl.create(:tmp_user, email: 'zdenal@zdenal.com',
      apps: [@crashdesk, @harvester])
  end
  subject {@zdenal}
  its(:apps) {should be_blank}

  context 'when we run import service' do
    before do
      @import_service = Crashdesk::Services::ImportAppsFromTmpUser.new(@zdenal).run
    end
    its(:apps) {should have(2).items}
    its(:apps) {should include(@crashdesk)}
    its(:apps) {should include(@harvester)}
    it "should remove tmp_zdenal" do
      TmpUser.all.should_not include(@tmp_zdenal)
    end
  end
end
