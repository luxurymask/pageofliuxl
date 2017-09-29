package pageofliuxl;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;

public class PVCounter {
	protected MongoCollection collection = null;
	
	public static final String MONGODB_SERVER = "127.0.0.1:27017";
	
	public static PVCounter instance = new PVCounter();
	
	protected long pvCount;
	
	private Object pvCountLock;
	
	private PVCounter(){
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("PV");
	}
	
	public void setPV(String ip, long timestamp){
		Document document = new Document();
		document.put("ip", ip);
		document.put("timestamp", timestamp);
		
		synchronized(pvCountLock){
			
		}
	}
	
	public int getPV(){
		return -1;
	}
}
