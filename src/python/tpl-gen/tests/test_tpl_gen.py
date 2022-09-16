import os
from tpl_gen import main, set_vars


def test_main():
    if os.getenv("ENV") is None:
        os.environ["ENV"] = "lde"

    _, env, product_dir, __ = set_vars()
    main()

    gen_file_p = os.path.join(product_dir, "src", "bash",
                              "demo", "lde", "demo.sh")
    gen_file_contents = ""

    with open(gen_file_p, mode = "r",  encoding="utf-8") as gen_file:
        gen_file_contents = gen_file.read()

    assert gen_file_contents == f"""#!/usr/bin/env bash

echo ENV is {env}
echo app_http_listen_port is 8080
sleep 3"""
