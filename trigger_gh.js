const https = require('https');

const owner = process.env.REPO_OWNER || 'marieltrisha01-cpu';
const repo = process.env.REPO_NAME || 'ASTRAL-VM';
const workflowId = 'main.yml';
const token = process.env.GITHUB_TOKEN;

if (!token) {
  console.error('Error: GITHUB_TOKEN environment variable is missing.');
  process.exit(1);
}

const data = JSON.stringify({
  ref: 'main'
});

const options = {
  hostname: 'api.github.com',
  port: 443,
  path: `/repos/${owner}/${repo}/actions/workflows/${workflowId}/dispatches`,
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'Content-Length': data.length,
    'User-Agent': 'Render-Cron-Job',
    'Authorization': `Bearer ${token}`,
    'Accept': 'application/vnd.github.v3+json'
  }
};

const req = https.request(options, (res) => {
  console.log(`Status Code: ${res.statusCode}`);
  
  if (res.statusCode === 204) {
    console.log('Workflow triggered successfully!');
  } else {
    console.error(`Failed to trigger workflow. Status: ${res.statusCode}`);
    res.on('data', (d) => {
      process.stdout.write(d);
    });
  }
});

req.on('error', (error) => {
  console.error('Error triggering workflow:', error);
});

req.write(data);
req.end();
