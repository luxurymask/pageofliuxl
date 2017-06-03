package pageofliuxl;

import org.bson.Document;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;
import com.sun.istack.internal.NotNull;

public class ContentStorage {

	protected MongoCollection collection = null;

	public static final ContentStorage instance = new ContentStorage();

	public static final String MONGODB_SERVER = "127.0.0.1:27017";
	
	public void save(String userId, String content) {
		Document document = new Document();
		document.put("userId", userId);
		document.put("content", content);
		long timestamp = System.currentTimeMillis();
		document.put("timestamp", timestamp);
		collection.insertOne(document);
	}
	
	private ContentStorage() {
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("blogContents");
	}
}
