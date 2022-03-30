require './leave'

describe Leave do
  let(:leave) { Leave.new('Peterpan1', 'TEAM_MEMBER_MAX_LEAVE_ALLOCATED', 2, 18) }

  it 'can be instantiated' do
    expect(leave).not_to be_nil
    expect(leave).to be_instance_of Leave
  end
  it 'return staffid' do
    expect(leave.staffid).to eq 'Peterpan1'
    expect(leave.staffid).not_to be_nil
    expect('Peterpan1').to end_with("1")
  end
  it 'return role' do
    expect(leave.role).not_to be_nil


end