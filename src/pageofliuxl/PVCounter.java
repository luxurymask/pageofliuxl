package pageofliuxl;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

public class PVCounter {
	protected MongoCollection<Document> collection = null;
	
	public static final String MONGODB_SERVER = "localhost:27017";
	
	public static PVCounter instance = new PVCounter();
	
	protected volatile long pvCount;
	
	private Object pvCountLock = new Object();
	
	private PVCounter(){
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("PV");
		initPVCount();
	}
	
	private void initPVCount(){
		Document document = new Document();
		Document sortType = new Document();
		sortType.put("timestamp", -1);
		MongoCursor<Document> cursor = collection.find(document).sort(sortType).iterator();
		if(cursor.hasNext()){
			pvCount = cursor.next().getLong("pvCount");
		}
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
	}
	
	public long getPV(){
		return pvCount;
	}
}
