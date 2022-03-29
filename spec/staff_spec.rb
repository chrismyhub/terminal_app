require './staff'

describe Staff do
  let(:staff) {Staff.new('Peterpan1', 'Peter Pan', 'TEAM_MEMBER_MAX_LEAVE_ALLOCATED', 'abc123')}
  
  it 'can be instantiated' do
    expect(staff).not_to be_nil
    expect(staff).to be_instance_of Staff
  end
  it 'returns staffid' do
    expect(staff.staffid).to eq 'Peterpan1'
  end

end