import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
import * as requests from 'request';

admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

exports.sendStatsToDevices = functions.pubsub.schedule('0 21 * * *').timeZone("America/New_York").onRun(async context => {

    const querySnapshot = await db.collection('tokens').get();
    const tokens = querySnapshot.docs.map(snap => snap.id);
    const options: any = {
        headers: {
            'User-Agent': 'request',
            'Subscription-Key': '36b106f0492a462bbb5d886135f70033',
            'Cache-Control': 'no-cache'
        },
        json: true
    }
    requests.get('https://api.smartable.ai/coronavirus/stats/global', options, (error: any, response: any, body: any) => {
        const stats = body.stats;

        const payload = {
            notification: {
                title: 'COVID-19 Daily Update',
                body: `Total Confirmed: ${stats.totalConfirmedCases} (+${stats.newlyConfirmedCases})\nTotal Recoveries: ${stats.totalRecoveredCases} (+${stats.newlyRecoveredCases})\nTotal Deaths: ${stats.totalDeaths} (+${stats.newDeaths})`
            }
        }
        fcm.sendToDevice(tokens, payload).catch(err => console.log(err));
    })
})
