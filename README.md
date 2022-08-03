# Power BI Embed

A POC for embedding Power BI report in a web application, while storing user credentials in Hashicorp's vault.

# Prerequisites

1. Hashicorp's Vault
2. `nodejs`
3. `jq`
4. Power BI workspace, reports, datasets, and authentication all set up

## How to build and run

1. Clone the repository on your machine, or download the zip file

   ```
   $ git clone git@github.com:zbhavyai/power-bi-embed.git
   ```

2. Fill in the details in the file [`form_fill.sh`](form_fill.sh) with credentials of Power BI. In producton, these should not be stored in a bash script, but rather directly stored to vault using REST calls.

3. Fill in the `client_id`, `group_id`, and `report_id` in the file [`embed_data.sh`](embed_data.sh).

4. Start the vault server:

   ```
   $ cd vault
   $ chmod +x *sh

   $ ./vault_server.sh &> /dev/null &
   ```

5. Configure the vault using vault client

   ```
   $ ./vault_client.sh
   ```

6. Run the scripts `form_fill.sh` and `embed_data.sh`

   ```
   $ cd ../
   $ chmod +x *sh

   $ ./form_fill.sh
   $ ./embed_data.sh
   ```

7. Start and visit URL at `http://localhost:3006`. Your Power BI report should be visible.

   ```
   $ npm install
   $ npm start
   ```

## Attribution

Code adapted from [https://github.com/microsoft/PowerBI-client-react](https://github.com/microsoft/PowerBI-client-react).
