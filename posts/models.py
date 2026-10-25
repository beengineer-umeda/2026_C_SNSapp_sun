from django.conf import settings
from django.db import models


class Post(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        null=True,
        verbose_name="投稿者",
        related_name="created_posts",
    )
    content = models.TextField("本文", max_length=500)
    photo = models.ImageField(
        "添付画像", upload_to="post_photos/", null=True, blank=True
    )
    created_at = models.DateTimeField("投稿日時", auto_now_add=True)
    updated_at = models.DateTimeField("更新日時", auto_now=True)
    is_deleted = models.BooleanField("削除済み", default=False)

    class Meta:
        verbose_name = "投稿"
        verbose_name_plural = "1.投稿一覧"

    def __str__(self):
        return f"{self.content}({self.user.username})"