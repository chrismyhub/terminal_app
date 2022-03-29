require './staff'

describe Staff do
    it 'can be instantiated' do
        staff = Staff.new("Peterpan1", "Peter Pan", "TEAM_MEMBER_MAX_LEAVE_ALLOCATED", "abc123" )
        expect(staff).not_to be_nil
        expect(staff).to be_instance_of Staff
    end

end