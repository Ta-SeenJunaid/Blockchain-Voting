echo First let’s run the cryptogen tool.

../bin/cryptogen generate --config=./crypto-config.yaml

echo We need to tell theconfigtxgentool where to look for theconfigtx.yamlfile that it needs to ingest. We will tell it look in our present working directory:

export FABRIC_CFG_PATH=$PWD

echo Then, we’ll invoke the configtxgen tool to create the orderer genesis block:

../bin/configtxgen -profile OrdererGenesis -channelID byfn-sys-channel -outputBlock ./channel-artifacts/genesis.block

echo We will first define some environment variables

export CHANNEL_ONE_NAME=channel1
export CHANNEL_ONE_PROFILE=Channel1
export CHANNEL_TWO_NAME=channel2
export CHANNEL_TWO_PROFILE=Channel2
export CHANNEL_THREE_NAME=channel3
export CHANNEL_THREE_PROFILE=Channel3


echo Next, we need to create the channel transaction artifact.
echo The channel.tx artifact contains the definitions for our channel

../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputCreateChannelTx ./channel-artifacts/${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME


echo Next, we will define the anchor peer for channel 1

../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org1MSP

../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org2MSP

../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org3MSP

../bin/configtxgen -profile ${CHANNEL_ONE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org4MSPanchors_${CHANNEL_ONE_NAME}.tx -channelID $CHANNEL_ONE_NAME -asOrg Org4MSP


echo Next, we will define the anchor peer for channel 2

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org1MSP

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org2MSP

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org3MSP

../bin/configtxgen -profile ${CHANNEL_TWO_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org5MSPanchors_${CHANNEL_TWO_NAME}.tx -channelID $CHANNEL_TWO_NAME -asOrg Org5MSP


echo Next, we will define the anchor peer for channel 3

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org1MSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg Org1MSP

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org2MSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg Org2MSP

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org3MSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg Org3MSP

../bin/configtxgen -profile ${CHANNEL_THREE_PROFILE} -outputAnchorPeersUpdate ./channel-artifacts/Org6MSPanchors_${CHANNEL_THREE_NAME}.tx -channelID $CHANNEL_THREE_NAME -asOrg Org6MSP


echo First let’s start our network:

docker-compose -f docker-compose-cli.yaml -f docker-compose-couch.yaml -f docker-compose-etcdraft2.yaml up -d

