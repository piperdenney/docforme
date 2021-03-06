require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:user) {create(:user)}
  let!(:admin) {User.create(username: 'admin', email: 'admin@email.com', password: 'P@ssword1', admin: true)}
  let!(:superadmin) {User.create(username: 'superadmin', email: 'superadmin@email.com', password: 'P@ssword1', admin: true, superadmin: true)}
  describe 'admin attribute' do
    it 'a normal user created has admin attribute as false' do
      expect(user.admin).to be false
    end
    it 'a user created with admin true will be an admin' do
      expect(admin.admin).to be true
    end
    it 'can be appointed by superadmins' do
      user.make_admin(superadmin)
      expect(user.reload.admin).to be true
    end
    it 'cant appoint admins as a regular admin' do
      user.make_admin(user)
      expect(user.reload.admin).to be false
    end
    it 'can be removed by a superadmin' do
      admin.remove_admin(superadmin)
      expect(admin.reload.admin).to be false
    end
  end
end
