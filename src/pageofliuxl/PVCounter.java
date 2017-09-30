package pageofliuxl;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

public class PVCounter {
	protected MongoCollection<Document> collection = null;
	
	public static final String MONGODB_SERVER = "127.0.0.1:27017";
	
	public static PVCounter instance = new PVCounter();
	
	protected volatile long pvCount;
	protected volatile String newestId;
	
	private Object pvCountLock = new Object();
	private Object newestIdLock = new Object();
	
	private PVCounter(){
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("PV");
	}
	
	public void setPV(String clientIP, String pageURL, long timestamp){
		Document document = new Document();
		document.put("clientIP", clientIP);
		document.put("pageURL", pageURL);
		document.put("timestamp", timestamp);
		
		synchronized(pvCountLock){
			document.put("pvCount", ++pvCount);
			collection.insertOne(document);
		}
		MongoCursor<Document> cursor = collection.find(document).iterator();
		if (cursor.hasNext()) {
			synchronized(newestIdLock){
				newestId = cursor.next().get("_id").toString();
			}
		}
		cursor.close();
	}
	
	public long getPV(){
		return pvCount;
	}
}
