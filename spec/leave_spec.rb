require './leave'

describe Leave do
  let(:leave) { Leave.new('Peterpan1', 'TEAM_MEMBER_MAX_LEAVE_ALLOCATED', 2, 18) }

  it 'can be instantiated' do
    expect(leave).not_to be_nil 
  end


end