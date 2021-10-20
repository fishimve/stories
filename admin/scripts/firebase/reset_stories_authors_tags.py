import firebase_admin
from firebase_admin import credentials, firestore

cred = credentials.Certificate(
    "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")

firebase_admin.initialize_app(cred)

# init firestore
db = firestore.client()

batch = db.batch()

# add a language
language = u'English'

last_doc = db.collection(u'stories').document(u'Wh2CT2Uq9ZKotYcdeQDK').get()

# firestore subcollections
stories_docs = db.collection(u'stories').where(
    u'language', u'==', language).order_by(u'author').start_after(last_doc).stream()

lang_metadata = db.collection(u'metadata').document('languages')

authors_set = set()
tags_set = set()

# get all documents and extract authors
for doc in stories_docs:
    doc_ref = db.collection(u'stories').document(doc.id)
    doc = doc_ref.get()
    data = doc.to_dict()
    author = data.get('author').strip()
    print(doc.id)
    try:
        if author and author.strip():
            authors_set.add(author)
        storiesTags = data.get('tags')
        if len(storiesTags) != 0:
            tags_set.update(set(storiesTags))
    except:
        print('Failed to extract authors!')

# write the authors and tags to metadata
authors = list(authors_set)
authors.sort()

tags = list(tags_set)
tags.sort()

try:
    lang_metadata.set({
        language.lower(): {'authors': firestore.ArrayUnion(authors), 'storiesTags': firestore.ArrayUnion(tags)}
    }, merge=True)
    print('successfully authors and tags')
except:
    print('Failed to write to db')
