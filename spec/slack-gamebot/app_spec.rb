require 'spec_helper'

describe SlackGamebot::App do
  subject do
    SlackGamebot::App.new
  end
  context 'not configured' do
    it 'requires SLACK_API_TOKEN' do
      expect { subject }.to raise_error RuntimeError, "Missing ENV['SLACK_API_TOKEN']."
    end
  end
  context 'configured' do
    use_vcr_cassette 'auth_test'
    before do
      ENV['SLACK_API_TOKEN'] = 'token'
    end
    after do
      ENV.delete('SLACK_API_TOKEN')
    end
    it 'configures API token' do
      expect(subject.config.token).to_not be nil
    end
    context 'with auth' do
      context 'run' do
        before do
          subject.run
        end
        it 'succeeds auth' do
          expect(subject.config.url).to eq 'https://pingpong.slack.com/'
          expect(subject.config.team).to eq 'pingpong'
          expect(subject.config.user).to eq 'gamebot'
          expect(subject.config.team_id).to eq 'TDEADBEEF'
          expect(subject.config.user_id).to eq 'UBAADFOOD'
        end
      end
    end
  end
end