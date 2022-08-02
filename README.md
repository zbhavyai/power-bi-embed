# Power BI Embed

A POC for embedding Power BI report in a web application.

## How to build and run

1. Clone the repository on your machine, or download the zip file

   ```
   $ git clone git@github.com:zbhavyai/power-bi-embed.git
   ```

2. Fill in the details in the file [`embed_data.sh`](embed_data.sh) under section "# form data".

3. Run the script

   ```
   $ chmod +x embed_data.sh
   $ ./embed_data.sh
   ```

4. Start and visit URL at `http://localhost:3006`

   ```
   $ npm install
   $ npm start
   ```

## Attribution

Code adapted from [https://github.com/microsoft/PowerBI-client-react](https://github.com/microsoft/PowerBI-client-react).
