package groupware.beans;

public class MessageFileDto {
	private int msg_file_no;
	private String file_upload_name;
	private String file_save_name;
	private long file_size;
	private String file_type;
	private int message_no;
	public MessageFileDto() {
		super();
	}
	public int getMsg_file_no() {
		return msg_file_no;
	}
	public void setMsg_file_no(int msg_file_no) {
		this.msg_file_no = msg_file_no;
	}
	public String getFile_upload_name() {
		return file_upload_name;
	}
	public void setFile_upload_name(String file_upload_name) {
		this.file_upload_name = file_upload_name;
	}
	public String getFile_save_name() {
		return file_save_name;
	}
	public void setFile_save_name(String file_save_name) {
		this.file_save_name = file_save_name;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
	public String getFile_type() {
		return file_type;
	}
	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}
	public int getMessage_no() {
		return message_no;
	}
	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}
	
}
