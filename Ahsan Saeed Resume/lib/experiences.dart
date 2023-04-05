import 'package:flutter/material.dart';

class Experience {
  final String jobTitle;
  final String company;
  final String date;
  final Color color;
  final bool active;
  final String description;

  Experience(
      {this.jobTitle,
      this.company,
      this.date,
      this.color,
      this.active,
      this.description});
}

List<Experience> experiences = [
  new Experience(
      jobTitle: 'Flutter Expert',
      company: 'Tier3 Cyber Security Pakistan',
      date: 'Since 3:26:2023',
      color: Colors.orange,
      active: true,
      description: ''),
  new Experience(
      jobTitle: 'CEO/Threat Intelligence ',
      company: 'Tier3 Cyber Security Pakistan',
      date: '2023-2027',
      color: Colors.cyan,
      active: false,
      description:
          '- Tier3 Cyber Security Services Pakistan | Estb : 2011 - Member National Centre for Cyber Security Pakistan \n\n'
          '- Architected and developed a hybrid API (GraphQL/REST) with Node.js, Express, GraphQL, MongoDB \n\n'
          '- Designing and developing a marketplace for training centers based on React, Node.js, and GraphQL \n\n'
          '- Designing and developing a marketplace for training centers based on React, Node.js, and GraphQL. \n\n'
          '- Architecting large React/Redux applications.\n\n'),
  new Experience(
      jobTitle: 'Employee Details',
      company: 'Student',
      date: '2020-2023',
      color: Colors.cyan,
      active: false,
      description:
          '- Name: Ahsan Saeed \n\n'
          '- Father Name: Muhammad Saeed \n\n'
          '- Education: BSCS \n\n'
              '- Email: ahsansaeed234@gmail.com \n\n'
          '- Phone No: 03062447627 \n\n'),
  new Experience(
      jobTitle: 'Bachelor of Science in Computer Science',
      company: 'Comsats University Islamabad Vehari Campus',
      date: '2020-2023',
      color: Colors.blue,
      active: false,
      description:
          'Marks/CGPA: 3.00 \n\n'
          'Fsc: 890  \n\n'
          'Matric: 790 \n\n'),
  new Experience(
      jobTitle: 'Full Flutter Engineer',
      company: 'Comsats University Islamabad',
      date: '2020-2023',
      color: Colors.blue,
      active: false,
      description: ' I am Internship in Comsats University Software House'),
  new Experience(
      jobTitle: 'Full Web Developer',
      company: '',
      date: '2020-2023',
      color: Colors.deepPurple,
      active: false,
      description: 'i am web developer in Comsats University Software House')
];
