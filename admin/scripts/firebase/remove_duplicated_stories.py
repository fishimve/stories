import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(
    "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")

firebase_admin.initialize_app(cred)

# init firestore
db = firestore.client()

batch = db.batch()

last_doc = db.collection(u'stories').document(u'ZWDbhGIqp46lNB6VU8pM').get()

stories_docs = db.collection(u'stories').where(
    u'language', u'==', u'English').order_by(u'title').start_at(last_doc).stream()

storiestt = list()

# find and delete
for doc in stories_docs:
    doc_ref = db.collection(u'stories').document(doc.id)
    print('id', doc.id)
    doc = doc_ref.get()
    data = doc.to_dict()
    title = data.get('title')
    author = data.get('author')
    art = title + author
    try:
        if art in storiestt:
            print('Duplicate found: ', doc.id, title)
            delete_doc = db.collection(u'stories').document(doc.id)
            yes = delete_doc.delete()
            print(yes)
        else:
            storiestt.append(art)

    except:
        print('Failed!')

print(len(storiestt))
print('Success')
