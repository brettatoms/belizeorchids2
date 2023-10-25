import json
import re

from flask import Flask, g, request, render_template
from flask_static_digest import FlaskStaticDigest

app = Flask(__name__.split(".")[0])

flask_static_digest = FlaskStaticDigest()
flask_static_digest.init_app(app)

image_root = "https://s3.amazonaws.com/belizeorchids.com/images/orchids/"
thumb_root = image_root + "256x192/"

with open("belizeorchids/data/orchids.json") as f:
    db = [dict(name=k, **v) for k, v in json.load(f).items()]


@app.route("/", methods=["GET"])
def root():
    data = db
    q = request.args.get("q")
    if q:
        rx = re.compile(f".*?{q}.*?", re.I)
        data = [row for row in db if re.search(rx, row["name"]) is not None]

    return render_template(
        "index.html", orchids=data, image_root=image_root, thumb_root=thumb_root
    )


@app.route("/ping", methods=["GET"])
def ping():
    return "pong"


if __name__ == "__main__":
    app.run()
