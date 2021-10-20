# ##################
# #
# #   REMEMBER TO DELETE THE COLLECTION OF INDEXEDARTICLES BEFORE RUNNIN THIS SCRIPT
# #   BECAUSE THERE WILL BE DUPLICATES
# #
# ##########################


# import firebase_admin
# from firebase_admin import credentials, firestore

# cred = credentials.Certificate(
#     "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")

# firebase_admin.initialize_app(cred)

# # init firestore
# db = firestore.client()

# batch = db.batch()

# last_doc = db.collection(u'stories').document(u'Wh2CT2Uq9ZKotYcdeQDK').get()

# # firestore subcollection
# stories_docs = db.collection(u'stories').where(
#     u'language', u'==', u'English').start_after(last_doc).stream()

# # copy all articles in their indexed collections
# for doc in stories_docs:
#     try:
#         # add where of visibility is true
#         from_doc_ref = db.collection(u'stories').document(doc.id)
#         doc = from_doc_ref.get()
#         data = doc.to_dict()
#         title = data.get('title')
#         firstChar = ''
#         if(title[0:4] == 'The '):
#             firstChar = title[4].upper()
#         else:
#             firstChar = title[0].upper()
#         to_doc_ref = db.collection(u'indexedStories').document(
#             firstChar).collection(f'{firstChar}_Stories').document()
#         to_doc_ref.set(data)

#     except:
#         print('Failed!')

# print('Success')
