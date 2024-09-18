
const {generateToken} = require('../middleware/jwt')
const bcrypt = require('bcrypt');
const defaultImageBuffer = 'https://i.pinimg.com/736x/0d/64/98/0d64989794b1a4c9d89bff571d3d5842.jpg';
const {generateID} = require("../middleware/generateID");
const Admin = require('../models/admin');



async function handleAddAdmin (req,res)

 {
    try {
      const formData = req.body;
  
      // Check if client with the same email exists
      const existingAdmin = await Admin.findOne({
        where: {
          email: formData.email
        }
      });
  
      if (existingAdmin) {
        
        return res.status(400).json({msg:"try another Email adress"});
      }

      const idUser = generateID();

      // Create a new user
      const admin = await Admin.create({
        id : idUser,
        last_name: formData.last_name,
        name: formData.name,
        email: formData.email,
        phone: formData.phone,
        address: formData.address,
        password: await bcrypt.hash(formData.password, 10), // Ensure to hash this password before saving
        photo : defaultImageBuffer,
        city : formData.city,
        country : formData.country
      });

      const myToken = generateToken(admin.toJSON());
      return res.status(200).json({ token: myToken, id : admin.id , email : admin.email , name : admin.name , last_name : admin.last_name , phone : admin.phone , photo : admin.photo , password : admin.password , address : admin.address , city : admin.city, country : admin.country});
      
    } catch (error) {
      console.error("Error:", error);
      res.status(500).send("Error is occured when handle Add user");
    }
};
module.exports={handleAddAdmin};
