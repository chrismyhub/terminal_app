require './staff'

describe Staff do
  let(:staff) { Staff.new('Peterpan1', 'Peter Pan', 'TEAM_MEMBER_MAX_LEAVE_ALLOCATED', 'abc123') }

  it 'can be instantiated' do
    expect(staff).not_to be_nil
    expect(staff).to be_instance_of Staff
  end
  it 'returns staffid' do
    expect(staff.id).not_to be_nil
    expect(staff.id).to eq 'Peterpan1'
    expect('Peterpan1').to end_with("1")
  end
  it 'returns name' do
    expect(staff.name).not_to be_nil
    expect(staff.name).to eq 'Peter Pan'
    expect("Peter Pan").to include("ter Pa")
  end
  it 'returns role' do
    expect(staff.role).not_to be_nil
    expect(staff.role).to eq 'TEAM_MEMBER_MAX_LEAVE_ALLOCATED'
    expect("TEAM_MEMBER").to include("AM_MEM")
  end
  it 'returns password' do
    expect(staff.password).not_to be_nil
    expect(staff.password).to eq 'abc123'
  end
end


describe "get_name" do
    let(:name) { "James" }

    it "should be 'James" do
      expect(name).to eq 'James'
    end
  end