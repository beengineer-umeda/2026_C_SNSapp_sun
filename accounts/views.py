from rest_framework import generics, mixins

from .serializers import RegisterSerializer


class RegisterView(generics.GenericAPIView, mixins.CreateModelMixin):
    serializer_class = RegisterSerializer

    def post(self, request, *args, **kwargs):
        return self.create(request, *args, **kwargs)