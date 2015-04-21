
import java.io.File;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import video.S3Instance;

public class UploadServlet extends HttpServlet
{
	/**
	 * 
	 */
	private static S3Instance s3_instance = null;
	private static final long serialVersionUID = 1L;
	private boolean isMultipart;
	private String filePath;
//	private int maxFileSize = 10000 * 1024;
//	private int maxMemSize = 4 * 1024;
	private File file ;

	public void init( )
	{
		// Get the file location where it would be stored.
		filePath = getServletContext().getInitParameter("file-upload"); 
	}
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, java.io.IOException 
	{
		java.io.PrintWriter out = response.getWriter( );

		// Check that we have a file upload request
		try
		{
			if(s3_instance == null)
				s3_instance=new S3Instance(true);
		}
		catch(Exception e)
		{
			out.println("S3 Instance ERROR "+e);
			System.out.println("S3 Instance ERROR "+e);
		}
		isMultipart = true;//ServletFileUpload.isMultipartContent(request);
		response.setContentType("text/html");
		if( !isMultipart )
		{
			out.println("<html>");
			out.println("<head>");
			out.println("<title>Servlet upload</title>"); 	 
			out.println("</head>");
			out.println("<body>");
			out.println("<p>No file uploaded</p>"); 
			out.println("</body>");
			out.println("</html>");
			return;
		}
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
		ServletFileUpload upload = new ServletFileUpload(factory);
		try
		{ 
			// Parse the request to get file items.
			List fileItems = upload.parseRequest(request);
			
			// Process the uploaded file items
			Iterator i = fileItems.iterator();
			
			out.println("<html>");
			out.println("<head>");
			out.println("<meta http-equiv=\"refresh\" content=\"5;Url=http://youtubeonaws.elasticbeanstalk.com\">");
			out.println("<title>Servlet upload</title>");  
			out.println("</head>");
			out.println("<body>");
			while ( i.hasNext () ) 
			{
				FileItem fi = (FileItem)i.next();
				if ( !fi.isFormField () )	
				{
					// Get the uploaded file parameters
//					String fieldName = fi.getFieldName();
					String fileName = fi.getName();
//					String contentType = fi.getContentType();
//					boolean isInMemory = fi.isInMemory();
//					long sizeInBytes = fi.getSize();
					System.out.println(fileName);
					// Write the file
					if( fileName.lastIndexOf("\\") >= 0 )
					{
						file = new File( filePath + fileName.substring( fileName.lastIndexOf("\\"))) ;
					}
					else
					{
						file = new File( filePath + fileName.substring(fileName.lastIndexOf("\\")+1)) ;
					}
					fi.write( file ) ;
//					System.out.println("File path : "+file.getAbsolutePath()+"1234567890");
					String s = fileName;
					if(s.endsWith("wmv") || s.endsWith("flv") || s.endsWith("mp4") || s.endsWith("ogv") || s.endsWith("webm") || s.endsWith("mov") || s.endsWith("m4v") || s.endsWith("f4v"))
					{
						s3_instance.addToBucket(file.getAbsolutePath(),fileName);
						out.println("File Uploaded successfully ! ! ! <br><br><hr>");
						out.println("Redirecting, Please wait...");
					}
					else
					{
						out.println("Incompatible Format...");
					}
//					S3Instance s  = new S3Instance(false);
//					LinkedList<String> a =s.getAllVideoNames();
//					for(int j=0;j<a.size();j++)
//						out.println(a.get(j));
				}
			}
			out.println("</body>");
			out.println("</html>");
		}
		catch(Exception ex) 
		{
			out.println(ex);
			System.out.println(ex);
		}
//		amazon_instance.destroy();
	}
	public void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException, java.io.IOException 
	{       
		throw new ServletException("GET method used with " + getClass( ).getName( )+": POST method required.");
	} 
}