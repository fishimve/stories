# # import os
# import glob
# import random

# import firebase_admin
# from firebase_admin import credentials, firestore
# from firebase_admin.firestore import SERVER_TIMESTAMP

# cred = credentials.Certificate(
#     "admin/scripts/firebase/keys/world-stories-collection-firebase-adminsdk-9f29p-dd45a7df50.json")
# firebase_admin.initialize_app(cred)

# # init firestore
# db = firestore.client()


# def set_file_to_firestore(file):
#     try:
#         with open(file, "rt", encoding='utf-8') as f:

#             # read the first 4 lines and extract title, author, source, and tags
#             title = f.readline()[5:].strip(": \n")
#             author = f.readline()[6:].strip(": \n")
#             source = f.readline()[6:].strip(": \n")
#             tags = f.readline()[4:].strip(": \n").title().split(", ")
#             # written = f.readline()[7:].strip(": \n")
#             language = f.readline()[8:].strip(": \n")

#             # extract the content and remove extra spaces at end
#             f.seek(0, 1)
#             content = f.read().strip()

#             # firestore collections
#             doc_ref = db.collection(u'stories').document()

#             # set the extraced content to firestore
#             try:
#                 doc_ref.set({
#                     u'title': title,
#                     u'id': doc_ref.id,
#                     u'author': author,
#                     u'source': source,
#                     u'createdTime': SERVER_TIMESTAMP,
#                     u'tags': tags,
#                     u'content': content,
#                     # u'written': written,
#                     u'language': language,
#                     u'visibility': 'public',
#                     u'rating': random.uniform(1, 100)
#                 })

#                 # upload to indexed collection
#                 firstChar = ''
#                 if(title[0:4] == 'The '):
#                     firstChar = title[4].upper()
#                 else:
#                     firstChar = title[0].upper()
#                 index_doc_ref = db.collection(u'indexedStories').document(
#                     firstChar).collection(f'{firstChar}_Stories').document()
#                 index_doc_ref.set({
#                     u'title': title,
#                     u'id': doc_ref.id,
#                     u'author': author,
#                     u'source': source,
#                     u'createdTime': SERVER_TIMESTAMP,
#                     u'tags': tags,
#                     u'content': content,
#                     # u'written': written,
#                     u'language': language,
#                     u'visibility': 'public',
#                 })

#                 print(doc_ref.id, "succeeded!")

#             except:
#                 print(doc_ref.id, "failed to write!.")

#     except:
#         print("failed to open!.")

#     return "Success"


# # run the script
# txt_files = glob.glob("admin/content/kinyarwanda/published/*.txt")
# result = list(map(set_file_to_firestore, txt_files))

# print(len(result), "files successfully set to firestore")
