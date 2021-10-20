# import firebase_admin
# from firebase_admin import credentials, firestore

# cred = credentials.Certificate(
#     "scripts/firebase/keys/rubanda_serviceAccountKey.json")
# # cred = credentials.Certificate(
# #     "scripts/firebase/keys/rubanda-development.json")

# firebase_admin.initialize_app(cred)

# # init firestore
# db = firestore.client()

# # firestore subcollection
# # doc_ref_article = db.collection(u'articles').document(u'-')

# docs = db.collection(u'articles').where(
#     u'author', u'==', u'Victor Hugo').stream()

# imageUrl = u""


# # write to firestore
# # try:
# #     doc_ref_article.update({
# #         u'imageUrl': imageUrl,
# #     })
# #     print("Success to", doc_ref_article.id)
# # except:
# #     print('writing to firestore failed!')

# for d in docs:
#     doc_ref_article = db.collection(u'articles').document(d.id)
#     try:
#         doc_ref_article.update({
#             u'imageUrl': imageUrl,
#         })
#         print("Success to", doc_ref_article.id)
#     except:
#         print('writing to firestore failed!')
