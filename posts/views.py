from rest_framework import generics
from rest_framework.permissions import IsAuthenticated

from posts.models import Post
from posts.serializers import PostSerializer

class PostListView(generics.ListAPIView):
    permission_classes = [IsAuthenticated]
    serializer_class = PostSerializer
    queryset = Post.objects.filter(is_deleted=False).order_by("-created_at")