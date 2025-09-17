import { faker, fi } from '@faker-js/faker';
import express from 'express';
import fs from 'fs';
import path, { dirname } from 'path';
import { fileURLToPath } from 'url';

const app = express();
const port = 8080;

// Convert import.meta.url to a file path
const __filename = fileURLToPath(import.meta.url);
const __dirname = dirname(__filename);

const jwtConfigFilePath = 'api/account/jwt_expires_at_time';

app.use(express.json());

app.get('/', (req, res) => {
    res.send('Welcome to my server!');
});

function getNewExpiresAt() {
    const nowTime = new Date().getTime();
    return nowTime + 60000 * 5;
}

function checkJwt(authorization, callback) {
    console.log('authorization: ', authorization);

    if (!authorization) {
        callback(isExpired, null);
        return;
    }

    const nowTime = new Date().getTime();

    readJsonFile(jwtConfigFilePath, jwtConfigResult => {
        const expiresAtTime = parseInt(jwtConfigResult.expiresAt);
        const isExpired = expiresAtTime < nowTime;
        console.log(`1. Checking jwt: ${isExpired ? 'EXPIRED' : 'ALL GOOD'} ${nowTime} > ${expiresAtTime}`);
        callback(isExpired, jwtConfigResult);
    });
}

app.post('/api/authenticate', (req, res) => {
    const file = 'api/authenticate';

    readJsonFile(jwtConfigFilePath, jwtConfigResult => {
        jwtConfigResult.expiresAt = getNewExpiresAt();

        writeJsonFile(jwtConfigFilePath, JSON.stringify(jwtConfigResult, null, 2), () => {
            sendJsonFile(res, file);
        });
    });
});

app.get('/api/account', (req, res) => {
    let file = 'api/account/';

    checkJwt(req.headers.authorization, (isExpired, jwtConfigResult) => {
        if (isExpired) return res.status(401).send('Unauthorized');

        readJsonFile('api/account/__scenario', result => {
            // 'no-authorities', 'default', 'NOT_AUTHORIZED'
            if (result.scenarioFile === 'NOT_AUTHORIZED') {
                return res.status(401).send('Unauthorized');
            }

            jwtConfigResult.expiresAt = getNewExpiresAt();

            writeJsonFile(jwtConfigFilePath, JSON.stringify(jwtConfigResult, null, 2), () => {
                file += '_' + result.scenarioFile;
                sendJsonFile(res, file);
            });
        });
    });
});

app.post('/api/account/reset-password/finish', (req, res) => {
    res.status(200).send();
});

app.get('/api/management/info', (req, res) => {
    const file = 'api/management/info';
    sendJsonFile(res, file);
});

////////

app.get('/api/po-windows/current', (req, res) => {
    const file = 'api/po-windows/current';
    setTimeout(
        () => {
            sendJsonFile(res, file);
        },
        faker.number.int({ min: 250, max: 750 }),
    );
});

app.get('/api/po-windows/past', (req, res) => {
    const file = 'api/po-windows/past';
    setTimeout(
        () => {
            sendJsonFile(res, file);
        },
        faker.number.int({ min: 250, max: 750 }),
    );
});

// /api/po-windows?page=0&size=20&sort=id,asc
app.get('/api/po-windows', (req, res) => {
    const file = 'api/po-windows';
    sendJsonFile(res, file);
});

// api/po-windows/download-template
app.get('/api/po-windows/download-template', (req, res) => {
    res.setHeader('Content-Type', 'application/octet-stream');
    res.setHeader('Filename', 'Template_Upload_PO.xlsx');
    res.setHeader('Content-Disposition', 'attachment; filename=Template_Upload_PO.xlsx');
    res.setHeader('Content-Length', '14115');

    const file = 'api/po-windows/download-template/_template';

    sendXlsxFile(res, file);
});

app.post('/api/export-as-excel', (req, res) => {
    res.setHeader('Content-Type', 'application/octet-stream');
    res.setHeader('Filename', 'Template_Upload_PO.xlsx');
    res.setHeader('Content-Disposition', 'attachment; filename=Template_Upload_PO.xlsx');
    res.setHeader('Content-Length', '14115');

    const file = 'api/po-windows/download-template/_template';

    sendXlsxFile(res, file);
});

app.post('/api/upload-file', (req, res) => {
    const file = 'api/upload-file/_call';
    sendJsonFile(res, file);
});

app.get('/api/upload-file/check-status/:id', (req, res) => {
    const file = 'api/upload-file/check-status/_latest';
    sendJsonFile(res, file, '.txt');
});

app.get('/api/upload-file/errors/:id', (req, res) => {
    const file = 'api/upload-file/errors/_latest';
    sendJsonFile(res, file);
});

app.post('/api/upload-file/call-sap-interface', (req, res) => {
    setTimeout(
        () => {
            const file = 'api/upload-file/call-sap-interface/_latest';
            sendJsonFile(res, file);
        },
        faker.number.int({ min: 150, max: 350 }),
    );
});

app.get('/api/regions', (req, res) => {
    const file = 'api/regions';
    sendJsonFile(res, file);
});

// api/companyCountryRegion/countries/EMEA
app.get('/api/companyCountryRegion/countries/EMEA', (req, res) => {
    const file = 'api/companyCountryRegion/countries/EMEA';
    sendJsonFile(res, file);
});

// api/companyCountryRegion/companies/EMEA/ALL
app.get('/api/companyCountryRegion/companies/EMEA/ALL', (req, res) => {
    const file = 'api/companyCountryRegion/companies/EMEA/ALL';
    sendJsonFile(res, file);
});

// /api/users?page=0&size=20&sort=id,asc
app.get('/api/users', (req, res) => {
    console.log('req.query: ', req.query);

    const file = 'api/users/_all';
    res.setHeader('X-Total-Count', 228);

    readJsonFile(file, data => {
        const sortBy = req.query.sort.split(',');

        console.log('sortBy: ', sortBy);

        const sortedData =
            sortBy[1] === 'asc' ? data.sort((a, b) => a[sortBy[0]] - b[sortBy[0]]) : data.sort((a, b) => b[sortBy[0]] - a[sortBy[0]]);

        const size = parseInt(req.query.size, 10);
        const page = parseInt(req.query.page, 10);
        console.log('size, page: ', [size, page]);

        const first = Math.floor(size * page);
        const last = size * (page + 1);
        console.log('first, last: ', [first, last]);

        const dataToSend = sortedData.slice(first, last);
        res.send(dataToSend);
    });

    // sendJsonFile(res, file);
});

app.post('/api/users', (req, res) => {
    const file = 'api/users/madhurima';
    sendJsonFile(res, file);
});

app.get('/api/users/:login', (req, res) => {
    let file = 'api/users/';
    if (req.params.login === 'madhurima' || req.params.login === 'natbat') {
        file += req.params.login;
    } else {
        file += '_default-user';
    }
    sendJsonFile(res, file);
});

app.get('/api/users/authorities', (req, res) => {
    console.log('----------------------------');
    const file = 'api/users/authorities';
    setTimeout(() => {
        sendJsonFile(res, file);
    }, 250);
});

////////

// management/audits?size=10&fromDate=2024-09-23&toDate=2024-10-24&page=0&sort=auditEventDate,asc
app.get('/api/management/audits', (req, res) => {
    const file = 'management/audits';
    res.setHeader('x-total-count', 24);
    sendJsonFile(res, file);
});

app.get('/api/management/configprops', (req, res) => {
    setTimeout(() => {
        const file = 'management/configprops';
        sendJsonFile(res, file);
    }, 750);
});

app.get('/api/management/env', (req, res) => {
    const file = 'management/env';
    sendJsonFile(res, file);
});

app.get('/api/management/pometrics', (req, res) => {
    // const file = 'management/jhimetrics';
    const file = 'management/pometrics';
    sendJsonFile(res, file);
});

app.get('/api/management/threaddump', (req, res) => {
    const file = 'management/threaddump';
    sendJsonFile(res, file);
});

// scheduledtasks
app.get('/api/management/scheduledtasks', (req, res) => {
    const file = 'management/scheduledtasks';
    sendJsonFile(res, file);
});

// /management/loggers
app.get('/api/management/loggers', (req, res) => {
    const file = 'management/loggers';
    sendJsonFile(res, file);
});

//
app.get('/api/purchase-orders', (req, res) => {
    console.log('req.query: ', req.query);

    let file = '';

    if (req.query.page !== '0') {
        file = 'api/purchase-orders/_dashboard/_page+';
    } else {
        const pageSize = parseInt(req.query.size, 10);
        if (pageSize <= 20) {
            file = 'api/purchase-orders/_dashboard/_size' + pageSize;
        } else {
            file = 'api/purchase-orders/_dashboard/_size3';
        }
    }

    res.setHeader('x-total-count', 1721);

    setTimeout(
        () => {
            readJsonFile(file, result => {
                result.forEach(r => {
                    r.siteCode = faker.number.int({ min: 1234, max: 4321 }); // Random number for siteCode
                    r.siteName = faker.company.name(); // Random company name for siteName
                });

                res.send(result);
            });
        },
        faker.number.int({ min: 250, max: 500 }),
    );
});

app.get('/api/purchase-orders/KPI/:id', (req, res) => {
    const file = 'api/purchase-orders/KPI/238';
    sendJsonFile(res, file);
});

// /api/purchase-orders/all?poWindowId.equals=238&type.in=PO,FOR
// /api/purchase-orders/all?poWindowId.equals=243&type.notIn=PO,FOR
app.post('/api/purchase-orders/all', (req, res) => {
    const queryParams = req.query;
    console.log('Query Parameters:', queryParams);

    let file;
    if (req.query['type.in']) {
        file = 'api/purchase-orders/all';
    } else {
        file = 'api/purchase-orders/_allOthers';
    }

    sendJsonFile(res, file);
});

// MANAGEMENT
// CLUSTER MANAGEMENT

// api/vendors/dropdown/local/:payload
app.get('/api/vendors/dropdown/local/:payload', (req, res) => {
    const file = 'api/vendors/dropdown/local/_latest';
    sendJsonFile(res, file);
});

app.get('/api/vendors/dropdown/global/:payload', (req, res) => {
    const id = req.params.payload;

    const file = 'api/vendors/dropdown/global/_global';

    sendJsonFile(res, file);
});

app.get('/api/vendor-cluster-mappings', (req, res) => {
    res.setHeader('X-Total-Count', 8776);

    const file = 'api/vendor-cluster-mappings/latest';
    sendJsonFile(res, file);
});

app.get('/api/vendor-cluster-mappings/cluster-name-priority/:id', (req, res) => {
    const file = 'api/vendor-cluster-mappings/cluster-name-priority/_latest';
    sendJsonFile(res, file);
});

app.get('/api/cluster-codes', (req, res) => {
    let file = 'api/cluster-codes/';

    readJsonFile('api/cluster-codes/__scenario', result => {
        // 'latest', 'NOT_AUTHORIZED'
        if (result.scenarioFile === 'NOT_AUTHORIZED') {
            return res.status(401).send('Unauthorized');
        }
        file += '_' + result.scenarioFile;
        sendJsonFile(res, file);
    });
});

// CONFIGURATION
app.get('/api/target-spend-values/all', (req, res) => {
    const file = 'api/target-spend-values/all';
    sendJsonFile(res, file);
});

app.get('/api/target-spend-values/available-po-windows/:id', (req, res) => {
    const id = req.params.id;
    const file = `api/target-spend-values/available-po-windows/${id}`;
    checkFile(
        file,
        '.json',
        () => {
            sendJsonFile(res, file);
        },
        () => {
            const defaultFile = `api/target-spend-values/available-po-windows/284`;
            sendJsonFile(res, defaultFile);
        },
    );
});

app.get('/api/target-spend-values/auto-approve-osm-thresholds', (req, res) => {
    const file = 'api/target-spend-values/auto-approve-local-thresholds';
    sendJsonFile(res, file);
});

app.delete('/api/target-spend-values/:id', (req, res) => {
    const id = req.params.id;

    if (!id) {
        return res.status(400).json({ error: 'Missing required id: ' });
    }

    setTimeout(
        () => {
            res.send({});
        },
        faker.number.int({ min: 150, max: 350 }),
    );
});

app.post('/api/target-spend-values', (req, res) => {
    const payload = req.body;
    console.log('payload: ', payload);

    if (payload.targetBudget === 4) {
        return res.status(400).json({
            entityName: 'targetSpendValue',
            errorKey: 'null',
            type: 'https://www.jhipster.tech/problem/problem-with-message',
            title: 'The target already exists',
            status: 400,
            message: 'error.null',
            params: 'targetSpendValue',
        });
    }

    const invalidField = checkForInvalidTargetValues(payload);
    if (!invalidField) {
        payload.id = faker.number.int({ min: 2500, max: 5000 });

        setTimeout(
            () => {
                res.send(payload);
            },
            faker.number.int({ min: 150, max: 350 }),
        );
        return;
    }

    return res.status(400).json({ error: 'Missing required fields: ' + invalidField });
});

app.put('/api/target-spend-values', (req, res) => {
    const payload = req.body;
    console.log('payload: ', payload);

    const invalidField = checkForInvalidTargetValues(payload, 'put');
    if (!invalidField) {
        setTimeout(
            () => {
                res.send(payload);
            },
            faker.number.int({ min: 150, max: 350 }),
        );
        return;
    }

    return res.status(400).json({ error: 'Missing required fields: ' + invalidField });
});

function checkForInvalidTargetValues(payload, operation = 'post') {
    if (!payload.globalBudget) {
        // 5000000
        return 'globalBudget';
    }
    if (!payload.globalBudgetBuffer) {
        // 1
        return 'globalBudgetBuffer';
    }
    if (operation === 'put' && !payload.id) {
        // 277427638
        return 'id';
    }
    if (!payload.localBudget) {
        // 5000000
        return 'localBudget';
    }
    if (!payload.localBudgetBuffer) {
        // 1
        return 'localBudgetBuffer';
    }
    if (!payload.localThreshold) {
        // 7500
        return 'localThreshold';
    }
    if (!payload.localTotalAmountThreshold) {
        // 30010
        return 'localTotalAmountThreshold';
    }
    if (!payload.orderWeek) {
        // "202429"
        return 'orderWeek';
    }
    if (operation === 'put' && !payload.poWindowId) {
        // 238
        return 'poWindowId';
    }
    if (!payload.targetBudget) {
        // 10000000
        return 'targetBudget';
    }
    if (!payload.targetBudgetBuffer) {
        // 1
        return 'targetBudgetBuffer';
    }
    return null;
}

app.get('/api/other-po-types', (req, res) => {
    const file = 'api/other-po-types';
    sendJsonFile(res, file);
});

app.get('/api/po-types', (req, res) => {
    res.setHeader('X-Total-Count', 1661);

    const file = 'api/po-types/_latest';

    setTimeout(() => {
        sendJsonFile(res, file);
    }, 250);
});

app.post('/api/po-types', (req, res) => {
    const payload = req.body;
    console.log('payload: ', payload);

    if (
        !payload.poType || // 'FMG'
        !payload.vendorScope || // 'Global'
        !payload.vendorId || //: 28012,
        !payload.operationId || //: 43542,
        !payload.categoryId //: 43536
    ) {
        return res.status(400).json({ error: 'Missing required fields' });
    }

    payload.id = faker.number.int({ min: 2500, max: 5000 });

    setTimeout(
        () => {
            res.send(payload);
        },
        faker.number.int({ min: 150, max: 350 }),
    );
});

app.delete('/api/po-types/:id', (req, res) => {
    // res.setHeader('X-Total-Count', 1661);

    // const file = 'api/po-types/_latest';

    setTimeout(() => {
        res.send({ id: 1 });
        // sendJsonFile(res, file);
    }, 250);
});

// STATUS & REPORTS

// Week Summary
app.get('/api/erp-sources', (req, res) => {
    const file = 'api/erp-sources';
    sendJsonFile(res, file);
});

app.get('/api/categories', (req, res) => {
    const file = 'api/categories';
    sendJsonFile(res, file);
});

app.get('/api/distinct-po-types', (req, res) => {
    const file = 'api/distinct-po-types';
    sendJsonFile(res, file);
});

app.get('/api/operations', (req, res) => {
    const file = 'api/operations';
    sendJsonFile(res, file);
});

app.delete('/api/purchase-orders/delete', (req, res) => {
    setTimeout(() => {
        res.send();
        // res.send({
        //     message: 'Success'
        // });
    }, 250);
});

app.get('/api/purchase-orders/summary-report/:id', (req, res) => {
    const file = 'api/purchase-orders/summary-report/_latest';
    sendJsonFile(res, file);
});

app.post('/api/purchase-orders/detailed-report/:id', (req, res) => {
    const file = 'api/purchase-orders/detailed-report/_latest';

    setTimeout(
        () => {
            sendJsonFile(res, file);
        },
        faker.number.int({ min: 250, max: 500 }),
    );
});

// EVOLUTION

app.get('/api/purchase-order-statuses', (req, res) => {
    const file = 'api/purchase-order-statuses/_all';
    sendJsonFile(res, file);
});

app.get('/api/po-windows/years', (req, res) => {
    setTimeout(() => {
        const params = req.query;
        console.log('---------- params: ', params);
        let file = '';
        if (params.years === '2023') {
            file = 'api/po-windows/years/_2023';
        } else {
            file = 'api/po-windows/years/_some'; // _some / _none
        }
        sendJsonFile(res, file);

        // res.status(500).json({ message: 'Internal Server Error' });
    }, 300);
});

app.post('/api/po-report-filter/vendors', (req, res) => {
    setTimeout(() => {
        const payload = req.body;

        let file = 'api/po-report-filter/vendors';
        if (payload.poTypes.length === 1 && payload.poTypes[0] === 'PO') {
            file = 'api/po-report-filter/vendors--one';
        }

        sendJsonFile(res, file);

        // res.status(500).json({ message: 'Internal Server Error' });
    }, 300);
});

app.post('/api/po-report-filter/regions', (req, res) => {
    setTimeout(() => {
        const payload = req.body;

        let file = 'api/po-report-filter/regions';
        if (payload.poTypes.length === 1) {
            file = 'api/po-report-filter/regions--one';
        }

        sendJsonFile(res, file);
    }, 300);
});

app.post('/api/po-report-filter/operations', (req, res) => {
    setTimeout(() => {
        const payload = req.body;

        let file = 'api/po-report-filter/operations';
        if (payload.poTypes.length === 1) {
            file = 'api/po-report-filter/operations--one';
        }

        sendJsonFile(res, file);
    }, 300);
});

//
app.post('/api/po-report-filter/categories', (req, res) => {
    setTimeout(() => {
        const payload = req.body;

        let file = 'api/po-report-filter/categories';
        if (payload.poTypes.length === 1) {
            file = 'api/po-report-filter/categories--one';
        }

        sendJsonFile(res, file);
    }, 300);
});

app.post('/api/po-report-filter/report', (req, res) => {
    setTimeout(() => {
        const file = 'api/po-report-filter/report--2024';
        sendJsonFile(res, file);
    }, 1250);
});

app.post('/api/po-report-filter/download/report', (req, res) => {
    setTimeout(() => {
        res.setHeader('Content-Type', 'application/octet-stream');
        res.setHeader('Filename', 'Template_Upload_PO.xlsx');
        res.setHeader('Content-Disposition', 'attachment; filename=Template_Upload_PO.xlsx');
        res.setHeader('Content-Length', '14115');

        const file = 'api/po-windows/download-template/_template';

        sendXlsxFile(res, file);
    }, 1250);
});

// -----------------------------------------------------------------

app.post('/api/purchase-orders/regions-by-po', (req, res) => {
    const file = 'api/purchase-orders/regions-by-po/_all';
    sendJsonFile(res, file);
});

app.post('/api/purchase-orders/vendors-by-po', (req, res) => {
    setTimeout(
        () => {
            const file = 'api/purchase-orders/vendors-by-po/_all';
            sendJsonFile(res, file);
        },
        randomIntFromInterval(250, 750),
    );
});

app.post('/api/purchase-orders/operations-by-po', (req, res) => {
    setTimeout(
        () => {
            const file = 'api/purchase-orders/operations-by-po/_all';
            sendJsonFile(res, file);
        },
        randomIntFromInterval(250, 750),
    );
});

app.post('/api/purchase-orders/categories-by-po', (req, res) => {
    const file = 'api/purchase-orders/categories-by-po/_all';
    sendJsonFile(res, file);
});
//

// ---- Recieved POs

app.get('/api/auto-upload/interfaceRequestsInfo/:id', (req, res) => {
    const params = req.params;
    const possibleIds = [240, 251, 253, 255];
    let index = possibleIds.findIndex(id => id === parseInt(req.params.id, 10));
    console.log('index: ', index);
    if (index < 0) {
        index = randomIntFromInterval(0, possibleIds.length - 1);
    }

    console.log('[' + index + '] params:', params);

    const file = 'api/auto-upload/interfaceRequestsInfo/' + possibleIds[index];
    sendJsonFile(res, file);
});

app.get('/api/release-status/:id', (req, res) => {
    const queryParams = req.query;
    console.log('Query Parameters:', queryParams);

    const file = 'api/release-status/240';
    sendJsonFile(res, file);
});

/////////////
////////-------------------------------------------------------
//                FORECAST ANALYSIS
///

const FORECAST_ANALYSIS_TOLERANCE_URL = `api/forecast-analysis-tolerance`;

app.get(`/${FORECAST_ANALYSIS_TOLERANCE_URL}/last`, (req, res) => {
    setTimeout(
        () => {
            const data = {
                id: faker.number.int({ min: 1, max: 9547 }),
                lowerLimit: faker.number.int({ min: -16, max: -4 }),
                upperLimit: faker.number.int({ min: 4, max: 32 }),
            };

            res.send(data);
        },
        faker.number.int({ min: 250, max: 750 }),
    );
});

app.get(`/${FORECAST_ANALYSIS_TOLERANCE_URL}/history`, (req, res) => {
    setTimeout(
        () => {
            const count = faker.number.int({ min: 4, max: 32 });
            const data = [];
            for (let i = 0; i < count; i++) {
                const dto_bufferSettings = {
                    id: faker.number.int({ min: 1, max: 9547 }),
                    lowerLimit: faker.number.int({ min: -16, max: -4 }),
                    upperLimit: faker.number.int({ min: 4, max: 32 }),
                };
                data.push({
                    ...dto_bufferSettings,
                    createdBy: faker.internet.email(),
                    createdDate: faker.date.recent(),
                });
            }

            res.send(data);
        },
        faker.number.int({ min: 250, max: 750 }),
    );
});

app.post(`/${FORECAST_ANALYSIS_TOLERANCE_URL}`, (req, res) => {
    setTimeout(
        () => {
            res.send({ id: faker.number.int({ min: 4, max: 32 }) });
        },
        faker.number.int({ min: 250, max: 750 }),
    );
});

app.get('/api/forecast-analysis/po-windows', (req, res) => {
    setTimeout(() => {
        var file = 'api/forecast-analysis/po-windows';

        sendJsonFile(res, file);
    }, 300);
});

app.get('/api/forecast-analysis/regions', (req, res) => {
    setTimeout(() => {
        const poWindowId = req.query?.poWindowId;

        let file = 'api/po-report-filter/regions';
        if (poWindowId === '253') {
            file = 'api/po-report-filter/regions--one';
        }

        sendJsonFile(res, file);
    }, 300);
});

app.get('/api/forecast-analysis/categories', (req, res) => {
    setTimeout(() => {
        console.log('req.query: ', req.query);
        const regionsIds = req.query.regionsIds.split(',');
        console.log('regionsIds: ', regionsIds);

        let file = 'api/po-report-filter/categories';
        if (regionsIds.length === 1) {
            file = 'api/po-report-filter/categories--one';
        }

        sendJsonFile(res, file);
    }, 300);
});

app.get('/api/forecast-analysis/region-aggregations', (req, res) => {
    // console.log('req.query: ', req.query);
    const regionsIds = req.query.regionsIds.split(',');

    const data = [];
    for (let i = 0; i < regionsIds.length; i++) {
        const forecast = {
            regionId: regionsIds[i],
            ...generateForecast(),
        };
        data.push(forecast);
    }

    setTimeout(
        () => {
            res.send(data);
        },
        faker.number.int({ min: 250, max: 500 }),
    );
});

app.get('/api/forecast-analysis/category-aggregations', (req, res) => {
    // console.log('req.query: ', req.query);
    const categoryIds = req.query.categoryIds.split(',');
    const regionIds = req.query.regionsIds.split(',');
    const data = [];

    if (regionIds.length < 3) {
        let forecast = {
            categoryId: categoryIds[0],
            ...generateForecast(),
        };
        data.push(forecast);
        forecast = {
            categoryId: categoryIds[categoryIds.length - 1],
            ...generateForecast(),
        };
        data.push(forecast);
    } else {
        for (let i = 0; i < categoryIds.length; i++) {
            const forecast = {
                categoryId: categoryIds[i],
                ...generateForecast(),
            };
            data.push(forecast);
        }
    }

    setTimeout(
        () => {
            res.send(data);
        },
        faker.number.int({ min: 250, max: 500 }),
    );
});

app.get('/api/forecast-analysis/status', (req, res) => {
    const data = [
        {
            description: 'Under forecasted',
        },
        {
            description: 'As forecasted',
        },
        {
            description: 'Over forecasted',
        },
    ];
    res.send(data);
});

app.get('/api/forecast-analysis/vendor-aggregations', (req, res) => {
    console.log('req.query: ', req.query);

    const regionCount = req.query?.regionsIds.split(',').length;
    const categoryCount = req.query?.categoryIds.split(',').length;

    let count = regionCount * categoryCount;
    console.log('count: ', count);
    res.setHeader('x-total-count', count);

    const file = 'api/po-report-filter/vendors';
    readJsonFile(file, vendors => {
        const data = [];
        if (count > vendors.length) {
            count = vendors.length;
        }
        for (let i = 0; i < count; i++) {
            const vendor = vendors[i];
            const forecast = {
                vendorCode: vendor.code,
                vendorDescription: vendor.description,
                ...generateForecast(),
            };
            data.push(forecast);
        }

        setTimeout(
            () => {
                res.send(data);
            },
            faker.number.int({ min: 250, max: 500 }),
        );
    });
});

function generateForecast() {
    const statuses = ['Under forecasted', 'As forecasted', 'Over forecasted'];
    return {
        forecastPW: faker.number.float({ min: 111, max: 1999 }),
        actualPO: faker.number.float({ min: 0.001, max: 1.22 }),
        forecastVSActual: faker.number.float({ min: 1234567891, max: 9234567891 }),
        forecastStatus: statuses[faker.number.int({ min: 0, max: 2 })],
    };
}

/////////////
////////-------------------------------------------------------
///

app.get('/api/custom-report-po/user', (req, res) => {
    const random = faker.number.int({ min: 500, max: 750 });

    const nrRows = faker.number.int({ min: 1, max: 5 });
    res.setHeader('x-total-count', nrRows);

    setTimeout(() => {
        const data = Array.from({ length: nrRows }, (_, index) => ({
            id: faker.number.int({ min: 100, max: 200 }) + index,
            name: faker.company.name(),
        }));

        res.send(data);
    }, random);
});

app.get('/api/custom-report-po/:id', (req, res) => {
    const random = faker.number.int({ min: 500, max: 750 });

    const file = 'api/custom-report-po/fields';
    readJsonFile(file, fields => {
        const fieldsNr = faker.number.int({ min: 1, max: fields.length / 2 });

        const randomFields = getRandomFields(fields, fieldsNr);

        const fieldData = randomFields.map((field, index) => ({
            fieldId: field.id,
            order: index + 1,
        }));

        const data = {
            id: faker.number.int({ min: 100, max: 300 }),
            name: faker.company.name().slice(0, 25),
            description: faker.lorem.sentence().slice(0, 50),
            fields: fieldData,
        };

        setTimeout(() => {
            res.send(data);
        }, random);
    });
});

function getRandomFields(fields, n) {
    if (n >= fields.length) return [...fields];

    const shuffled = [...fields];
    for (let i = shuffled.length - 1; i > 0; i--) {
        const j = Math.floor(Math.random() * (i + 1));
        [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]];
    }

    return shuffled.slice(0, n);
}

app.delete('/api/custom-report-po/delete/:id', (req, res) => {
    const random = faker.number.int({ min: 500, max: 750 });
    setTimeout(() => {
        res.send({ message: 'Custom Report deleted successfully' });
    }, random);
});

app.get('/api/custom-report-field/all', (req, res) => {
    const random = faker.number.int({ min: 500, max: 750 });
    setTimeout(() => {
        const file = 'api/custom-report-po/fields';
        sendJsonFile(res, file);
    }, random);
});

app.post('/api/custom-report-po', (req, res) => {
    const random = faker.number.int({ min: 250, max: 750 });
    setTimeout(() => {
        res.send({
            id: random,
            ...req.body,
        });
    }, random);
});

app.put('/api/custom-report-po', (req, res) => {
    const random = faker.number.int({ min: 250, max: 750 });
    setTimeout(() => {
        res.send({
            id: random,
            ...req.body,
        });
    }, random);
});

///
////////-------------------------------------------------------
/////////////

/////////////
////////-------------------------------------------------------
///

app.get('/api/final-releaser-configuration/all', (req, res) => {
    const random = faker.number.int({ min: 500, max: 2500 });

    setTimeout(() => {
        let file = 'api/final-releaser-configuration/all';

        sendJsonFile(res, file);
    }, random);

    /*
    const nrRows = faker.number.int({ min: 7, max: 35 });
    res.setHeader('x-total-count', nrRows);

    setTimeout(() => {
        const data = Array.from({ length: nrRows }, (_, index) => ({
            id: faker.number.int({ min: 100, max: 200 }) + index,
            level: faker.number.int({ min: 1, max: 2 }),
            company: {
                id: faker.number.int({ min: 10000, max: 99999 }),
                code: faker.string.alpha(3).toUpperCase(),
                hfmCode: faker.string.numeric(4),
                description: faker.company.name(),
                erpSystemId: faker.helpers.maybe(() => faker.number.int({ min: 100, max: 999 }), { probability: 0.5 }),
                subSystemId: faker.number.int({ min: 100, max: 999 }),
                regionId: faker.number.int({ min: 10000, max: 99999 }),
            },
            vendorScope: faker.helpers.arrayElement(['Local', 'Global']),
            vendor: {
                code: faker.string.numeric(7),
                description: faker.company.name(),
            },
            category: {
                id: faker.number.int({ min: 10000, max: 99999 }),
                code: faker.string.numeric(2),
                description: faker.commerce.department(),
            },
            siteCode: faker.string.numeric(4),
            finalReleaser: 'PPD',
        }));

        res.send(data);
    }, random);
    */
});

app.post('/api/final-releaser/save', (req, res) => {
    const random = faker.number.int({ min: 250, max: 750 });
    setTimeout(() => {
        res.send({
            id: random,
            ...req.body,
        });
    }, random);
});

app.delete('/api/final-releaser/delete/:id', (req, res) => {
    const id = req.params.id;

    if (!id) {
        return res.status(400).json({ error: 'Missing required id: ' });
    }

    setTimeout(
        () => {
            res.send({});
        },
        faker.number.int({ min: 150, max: 350 }),
    );
});

app.get('/api/vendors/scope', (req, res) => {
    const random = faker.number.int({ min: 500, max: 2500 });
    setTimeout(() => {
        const query = req.query;
        console.log('req: ', req);

        let file = 'api/po-report-filter/vendors';
        if (query.vendorScope === 'Local') {
            file = 'api/po-report-filter/vendors--one';
        }

        sendJsonFile(res, file);
    }, random);
});

//

/////////////
////////-------------------------------------------------------
///

app.get('/api/health-check/now', (req, res) => {
    const file = 'api/health-check/now';
    setTimeout(() => {
        sendJsonFile(res, file);
    }, 300);
});

app.get('/api/health-check/SAP', (req, res) => {
    const file = 'api/health-check/SAP';
    setTimeout(() => {
        sendJsonFile(res, file);
    }, 300);
});

app.get('/api/health-check/DIP', (req, res) => {
    const file = 'api/health-check/DIP';
    setTimeout(() => {
        sendJsonFile(res, file);
    }, 300);
});

///
////////-------------------------------------------------------
/////////////

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});

function sendXlsxFile(res, filePath, ext = '.xlsx') {
    fs.stat('data/' + filePath + ext, (err, stats) => {
        if (err) {
            console.error('File not found:', err);
            res.status(404).send('File not found');
            return;
        }

        res.setHeader('Content-Length', stats.size);
        const readStream = fs.createReadStream('data/' + filePath + ext);
        readStream.pipe(res);

        readStream.on('error', error => {
            console.error('Error reading the file:', error);
            res.status(500).send('Internal Server Error');
        });
    });
}

function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min);
}
