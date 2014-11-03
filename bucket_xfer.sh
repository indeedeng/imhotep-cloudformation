#!/bin/bash -v

SRC_BUCKET=$1
TSV_BUCKET=$2
DATASET_NAME=$3

CWD=`pwd`

mkdir -p /tmp/bucket_move
cd /tmp/bucket_move
touch 'iupload_$folder$'
aws s3 cp 'iupload_$folder$' s3://$TSV_BUCKET

touch 'failed_$folder$'
aws s3 cp 'failed_$folder$' s3://$TSV_BUCKET/iupload/
touch 'indexedtsv_$folder$'
aws s3 cp 'indexedtsv_$folder$' s3://$TSV_BUCKET/iupload/
touch 'tsvtoindex_$folder$'
aws s3 cp 'tsvtoindex_$folder$' s3://$TSV_BUCKET/iupload/

DATASET_HDFS_FOLDER_MARKER=$DATASET_NAME'_$folder$'
touch $DATASET_HDFS_FOLDER_MARKER
aws s3 cp $DATASET_HDFS_FOLDER_MARKER s3://$TSV_BUCKET/iupload/tsvtoindex/

aws s3 sync s3://$SRC_BUCKET s3://$TSV_BUCKET/iupload/tsvtoindex/$DATASET_NAME

cd $CWD
rm -r /tmp/bucket_move

echo "Done!"