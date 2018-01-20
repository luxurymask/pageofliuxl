package pageofliuxl;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.bson.Document;
import org.bson.types.ObjectId;
import org.json.JSONArray;
import org.json.JSONObject;

import com.mongodb.MongoClient;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoCursor;

public class ContentStorage {

	protected MongoCollection<Document> collection = null;

	public static final ContentStorage instance = new ContentStorage();

	public static final String MONGODB_SERVER = "localhost:27017";
	
	public void save(String title, String content) {
		Document document = new Document();
		document.put("title", title);
		document.put("content", content);
		long timestamp = System.currentTimeMillis();
		document.put("timestamp", timestamp);
		collection.insertOne(document);
	}
	
	public void save(String id, String title, String content) {
		Document documentOld = new Document();
		documentOld.put("_id", new ObjectId(id));
		Document document = new Document();
		document.put("title", title);
		document.put("content", content);
		long timestamp = System.currentTimeMillis();
		document.put("timestamp", timestamp);
		Document documentNew = new Document("$set", document);
		collection.updateOne(documentOld, documentNew);
	}
	
	public JSONObject read(String id){
		Document document = new Document();
		document.put("_id", new ObjectId(id));
		MongoCursor<Document> cursor = collection.find(document).iterator();
		JSONObject jsonObject = new JSONObject();
		if(cursor.hasNext()){
			Document result = cursor.next();
			jsonObject.put("title", result.getString("title"));
			jsonObject.put("content", result.getString("content"));
		}
		return jsonObject;
	}
	
	public JSONArray readAll(){
		JSONArray jsonArray = new JSONArray();
		Document document = new Document();
		Document sortType = new Document();
		sortType.put("timestamp", -1);
		MongoCursor<Document> cursor = collection.find(document).sort(sortType).iterator();
		while (cursor.hasNext()) {
			JSONObject jsonObject = new JSONObject();
			Document result = cursor.next();
			jsonObject.put("id", result.get("_id").toString());
			jsonObject.put("title", result.getString("title"));
			jsonObject.put("content", result.getString("content"));
	        Date date = new Date(result.getLong("timestamp"));
	        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        String time = simpleDateFormat.format(date);
			jsonObject.put("time", time);
			jsonArray.put(jsonObject);
		}
		cursor.close();
		return jsonArray;
	}
	
	private ContentStorage() {
		collection = new MongoClient(MONGODB_SERVER).getDatabase("pageofliuxl_debug").getCollection("blogContents");
	}
}
