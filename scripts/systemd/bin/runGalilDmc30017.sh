#!/usr/bin/env bash

set -u

if [ -z "$DMC30017_INSTANCE" ]; then
    echo "DMC30017_INSTANCE environment variable is not set." >&2
    exit 1
fi

export DMC30017_CURRENT_PV_AREA_PREFIX=DMC30017_${DMC30017_INSTANCE}_PV_AREA_PREFIX
export DMC30017_CURRENT_PV_DEVICE_PREFIX=DMC30017_${DMC30017_INSTANCE}_PV_DEVICE_PREFIX
export DMC30017_CURRENT_DEVICE_IP=DMC30017_${DMC30017_INSTANCE}_DEVICE_IP
export DMC30017_CURRENT_DEVICE_PORT=DMC30017_${DMC30017_INSTANCE}_DEVICE_PORT
export DMC30017_CURRENT_DEVICE_TELNET_PORT_SUFFIX=DMC30017_${DMC30017_INSTANCE}_TELNET_PORT_SUFFIX
export DMC30017_CURRENT_VELO=DMC30017_${DMC30017_INSTANCE}_VELO
export DMC30017_CURRENT_VMAX=DMC30017_${DMC30017_INSTANCE}_VMAX
export DMC30017_CURRENT_ACCL=DMC30017_${DMC30017_INSTANCE}_ACCL
export DMC30017_CURRENT_BDST=DMC30017_${DMC30017_INSTANCE}_BDST
export DMC30017_CURRENT_BVEL=DMC30017_${DMC30017_INSTANCE}_BVEL
export DMC30017_CURRENT_BACC=DMC30017_${DMC30017_INSTANCE}_BACC
export DMC30017_CURRENT_MRES=DMC30017_${DMC30017_INSTANCE}_MRES
export DMC30017_CURRENT_SREV=DMC30017_${DMC30017_INSTANCE}_SREV
export DMC30017_CURRENT_ERES=DMC30017_${DMC30017_INSTANCE}_ERES
export DMC30017_CURRENT_DHLM=DMC30017_${DMC30017_INSTANCE}_DHLM
export DMC30017_CURRENT_DLLM=DMC30017_${DMC30017_INSTANCE}_DLLM
export DMC30017_CURRENT_OFF=DMC30017_${DMC30017_INSTANCE}_OFF
export DMC30017_CURRENT_UEIP=DMC30017_${DMC30017_INSTANCE}_UEIP
export DMC30017_CURRENT_RTRY=DMC30017_${DMC30017_INSTANCE}_RTRY
export DMC30017_CURRENT_NTM=DMC30017_${DMC30017_INSTANCE}_NTM
export DMC30017_CURRENT_MTRTYPE=DMC30017_${DMC30017_INSTANCE}_MTRTYPE
export DMC30017_CURRENT_MTRON=DMC30017_${DMC30017_INSTANCE}_MTRON
export DMC30017_CURRENT_EGU=DMC30017_${DMC30017_INSTANCE}_EGU
export DMC30017_CURRENT_DEFAULT_HOMETYPE=DMC30017_${DMC30017_INSTANCE}_DEFAULT_HOMETYPE
export DMC30017_CURRENT_DEFAULT_LIMITTYPE=DMC30017_${DMC30017_INSTANCE}_DEFAULT_LIMITTYPE
# Only works with bash
export DMC30017_PV_AREA_PREFIX=${!DMC30017_CURRENT_PV_AREA_PREFIX}
export DMC30017_PV_DEVICE_PREFIX=${!DMC30017_CURRENT_PV_DEVICE_PREFIX}
export DMC30017_DEVICE_IP=${!DMC30017_CURRENT_DEVICE_IP}
export DMC30017_DEVICE_PORT=${!DMC30017_CURRENT_DEVICE_PORT}
export DMC30017_DEVICE_TELNET_PORT=${PROCSERV_DMC30017_PORT_PREFIX}${!DMC30017_CURRENT_DEVICE_TELNET_PORT_SUFFIX}
export DMC30017_VELO=${!DMC30017_CURRENT_VELO}
export DMC30017_VMAX=${!DMC30017_CURRENT_VMAX}
export DMC30017_ACCL=${!DMC30017_CURRENT_ACCL}
export DMC30017_BDST=${!DMC30017_CURRENT_BDST}
export DMC30017_BVEL=${!DMC30017_CURRENT_BVEL}
export DMC30017_BACC=${!DMC30017_CURRENT_BACC}
export DMC30017_MRES=${!DMC30017_CURRENT_MRES}
export DMC30017_SREV=${!DMC30017_CURRENT_SREV}
export DMC30017_ERES=${!DMC30017_CURRENT_ERES}
export DMC30017_DHLM=${!DMC30017_CURRENT_DHLM}
export DMC30017_DLLM=${!DMC30017_CURRENT_DLLM}
export DMC30017_OFF=${!DMC30017_CURRENT_OFF}
export DMC30017_UEIP=${!DMC30017_CURRENT_UEIP}
export DMC30017_RTRY=${!DMC30017_CURRENT_RTRY}
export DMC30017_NTM=${!DMC30017_CURRENT_NTM}
export DMC30017_MTRTYPE=${!DMC30017_CURRENT_MTRTYPE}
export DMC30017_MTRON=${!DMC30017_CURRENT_MTRON}
export DMC30017_EGU=${!DMC30017_CURRENT_EGU}
export DMC30017_DEFAULT_HOMETYPE=${!DMC30017_CURRENT_DEFAULT_HOMETYPE}
export DMC30017_DEFAULT_LIMITTYPE=${!DMC30017_CURRENT_DEFAULT_LIMITTYPE}

if [ -z "${DMC30017_CURRENT_DEVICE_TELNET_PORT_SUFFIX}" ]; then
    echo "TELNET port is not set." >&2
    exit 1
fi

./runProcServ.sh \
    -i "${DMC30017_DEVICE_IP}" \
    -p "${DMC30017_DEVICE_PORT}" \
    -P "${DMC30017_PV_AREA_PREFIX}" \
    -R "${DMC30017_PV_DEVICE_PREFIX}" \
    -s "${DMC30017_VELO}" \
    -x "${DMC30017_VMAX}" \
    -a "${DMC30017_ACCL}" \
    -d "${DMC30017_BDST}" \
    -v "${DMC30017_BVEL}" \
    -c "${DMC30017_BACC}" \
    -r "${DMC30017_MRES}" \
    -t "${DMC30017_SREV}" \
    -e "${DMC30017_ERES}" \
    -h "${DMC30017_DHLM}" \
    -l "${DMC30017_DLLM}" \
    -o "${DMC30017_OFF}" \
    -u "${DMC30017_UEIP}" \
    -y "${DMC30017_RTRY}" \
    -n "${DMC30017_NTM}" \
    -m "${DMC30017_MTRTYPE}" \
    -k "${DMC30017_MTRON}" \
    -g "${DMC30017_EGU}" \
    -w "${DMC30017_DEFAULT_HOMETYPE}" \
    -z "${DMC30017_DEFAULT_LIMITTYPE}"

