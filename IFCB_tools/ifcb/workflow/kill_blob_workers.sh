#!/bin/sh
ps ux | grep blob_extraction | awk '{print $2}' | xargs kill -9