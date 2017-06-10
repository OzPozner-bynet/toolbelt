class MixFiles
  include Sidekiq::Worker

  def perform(audio_id)
     audio= Audio.find(audio_id)
    file_left = audio.left
    file_right = audio.right
	path = audio.file_path
    output = "/tmp/#{Time.now.getutc.to_f.to_s.delete('.')}.mp3"
    _command = `ffmpeg -i #{file_left} -i #{file_right} -filter_complex "[0:a][1:a]amerge=inputs=2[aout]" -map "[aout]"  #{output}`
	if $?.to_i == 0
      video.mp4_file = File.open(output, 'r')
      video.save
      FileUtils.rm(output)
    else
      raise $?
    end
  end
end
